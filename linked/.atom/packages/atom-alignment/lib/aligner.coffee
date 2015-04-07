{Range} = require 'atom'

_ = require 'lodash'

module.exports =
    class Aligner
        # Public
        constructor: (@editor, @spaceChars, @matcher, @addSpacePostfix) ->
            @rows = []
            @alignments = []

        # Private
        __getRows: =>
            rowNums = []
            allCursors = []
            cursors = _.filter @editor.getCursors(), (cursor) ->
                allCursors.push(cursor)
                row = cursor.getBufferRow()
                if cursor.visible && !_.contains(rowNums, row)
                    rowNums.push(row)
                    return true

            if (cursors.length > 1)
                @mode = "cursor"
                for cursor in cursors
                    row = cursor.getBufferRow()
                    t = @editor.lineTextForBufferRow(row)
                    l = @__computeLength(t.substring(0,cursor.getBufferColumn()))
                    o =
                        text   : t
                        length : t.length
                        row    : row
                        column : l
                        virtualColumn: cursor.getBufferColumn()
                    @rows.push (o)

            else
                ranges = @editor.getSelectedBufferRanges()
                for range in ranges
                    rowNums = rowNums.concat(range.getRows())
                    rowNums.pop() if range.end.column == 0

                for row in rowNums
                    o =
                        text   : @editor.lineTextForBufferRow(row)
                        length : @editor.lineTextForBufferRow(row).length
                        row    : row
                    @rows.push (o)

                @mode = "align"

            if @mode != "cursor"
                @rows.forEach (o) ->
                    t = o.text.replace(/\s/g, '')
                    if t.length > 0
                        firstCharIdx = o.text.indexOf(t.charAt(0))
                        o.text = o.text.substr(0,firstCharIdx) + o.text.substring(firstCharIdx).replace(/\ {2,}/g, ' ')

        __getAllIndexes: (string, val, indexes) ->
            found = []
            i = 0
            loop
                i = string.indexOf(val, i)
                if i != -1 && !_.some(indexes, {index:i})
                    found.push({found:val,index:i})

                break if i == -1
                i++
            return found

        #generate the sequence of alignment characters computed from the first matching line
        __generateAlignmentList: () =>
            if @mode == "cursor"
                _.forEach @rows, (o) =>
                    part = o.text.substring(o.virtualColumn)
                    _.forEach @spaceChars, (char) ->
                        idx = part.indexOf(char)
                        if idx == 0 && o.text.charAt(o.virtualColumn) != " "
                            o.addSpacePrefix = true
                            o.spaceCharLength = char.length
                            return false
                    return
            else
                _.forEach @rows, (o) =>
                    _.forEach @matcher, (possibleMatcher) =>
                        @alignments = @alignments.concat (@__getAllIndexes o.text, possibleMatcher, @alignments)

                    if @alignments.length > 0
                        return false # exit if we got all alignments characters in the row
                    else
                        return true # continue
                @alignments = @alignments.sort (a, b) -> a.index - b.index
                @alignments = _.pluck @alignments, "found"
                return

        __computeLength: (s) =>
            diff = tabs = idx = 0
            tabLength = @editor.getTabLength()
            for char in s
                if char == "\t"
                    diff += tabLength - (idx % tabLength)
                    idx += tabLength - (idx % tabLength)
                    tabs++
                else
                    idx++

            return s.length+diff-tabs

        __computeRows: () =>
            max = 0
            if @mode == "align" || @mode == "break"
                matched = null
                idx = -1
                possibleMatcher = @alignments.shift()
                addSpacePrefix = @spaceChars.indexOf(possibleMatcher) > -1
                @rows.forEach (o) =>
                    o.splited = null
                    if !o.done
                        line = o.text
                        if (line.indexOf(possibleMatcher, o.nextPos) != -1)
                            matched = possibleMatcher
                            idx = line.indexOf(matched, o.nextPos)
                            len = matched.length
                            if @mode == "break"
                                idx += len-1
                                c = ""
                                blankPos = -1
                                quotationMark = doubleQuotationMark = 0
                                backslash = charFound = false
                                loop
                                    break if c == undefined
                                    c = line[++idx]
                                    if c == "'" and !backslash then quotationMark++
                                    if c == '"' and !backslash then doubleQuotationMark++
                                    backslash = if c == "\\" and !backslash then true else false
                                    charFound = if c != " " and !charFound then true else charFound
                                    if c == " " and quotationMark % 2 == 0 and doubleQuotationMark % 2 == 0 and charFound
                                        blankPos = idx
                                        break

                                idx = blankPos

                            next = if @mode == "break" then 1 else len

                            if idx isnt -1
                                splitString  = [line.substring(0,idx), line.substring(idx+next)]
                                o.splited = splitString
                                l = @__computeLength(splitString[0])
                                if max <= l
                                    max = l
                                    max++ if l > 0 && addSpacePrefix && splitString[0].charAt(splitString[0].length-1) != " "

                        found = false
                        _.forEach @alignments, (nextPossibleMatcher) ->
                            if (line.indexOf(nextPossibleMatcher, idx+len) != -1)
                                found = true
                                return false

                        o.stop = !found

                    return

                if (max >= 0)
                    max++ if max > 0

                    @rows.forEach (o) =>
                        if !o.done and o.splited and matched
                            splitString = o.splited
                            diff = max - @__computeLength(splitString[0])
                            if diff > 0
                                splitString[0] = splitString[0] + Array(diff).join(' ')

                            splitString[1] = " "+splitString[1].trim() if @addSpacePostfix && addSpacePrefix

                            if @mode == "break"
                                _.forEach splitString, (s, i) ->
                                    splitString[i] = s.trim()

                                o.text = splitString.join("\n")
                            else
                                o.text = splitString.join(matched)
                            o.done = o.stop
                            o.nextPos = splitString[0].length+matched.length
                        return
                return @alignments.length > 0
            else #cursor
                @rows.forEach (o) ->
                    if max <= o.column
                        max = o.column
                        part = o.text.substring(0,o.virtualColumn)
                        max++ if part.length > 0 && o.addSpacePrefix && part.charAt(part.length-1) != " "
                    return

                max++

                @rows.forEach (o) =>
                    line = o.text
                    splitString = [line.substring(0,o.virtualColumn), line.substring(o.virtualColumn)]
                    diff = max - @__computeLength(splitString[0])
                    if diff > 0
                        splitString[0] = splitString[0] + Array(diff).join(' ')

                    o.spaceCharLength ?= 0
                    splitString[1] = splitString[1].substring(0, o.spaceCharLength) + splitString[1].substr(o.spaceCharLength).trim()
                    if @addSpacePostfix && o.addSpacePrefix
                        splitString[1] = splitString[1].substring(0, o.spaceCharLength) + " " +splitString[1].substr(o.spaceCharLength)

                    o.text = splitString.join("")
                    return
                return false

        # Public
        align: (multiple) =>
            @__getRows()
            @__generateAlignmentList()
            if @rows.length == 1 && multiple
                @mode = "break"

            if multiple || @mode == "break"
                loop
                    cont = @__computeRows()
                    break if not cont
            else
                @__computeRows()

            @rows.forEach (o) =>
                @editor.setTextInBufferRange([[o.row, 0],[o.row, o.length]], o.text)
