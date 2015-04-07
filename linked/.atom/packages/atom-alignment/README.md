# atom-alignment package

[Atom package](https://atom.io/packages/atom-alignment)

> Inspired by sublime text plugin ([sublime_alignment](https://github.com/wbond/sublime_alignment))

## Usage

A simple key-binding for aligning multi-line, multi-cursor and multiple selections in Atom.

Use `ctrl+cmd+a` on Mac or `ctrl+alt+a` to align multiple matches. If you want to align the first match only, call `Atom Alignment:Align` from the command palette. The following examples all use the mentioned key binding to call `Atom Alignment:AlignMultiple`.

```javascript
var a = b;
var ab = c;
var abcd = d;
var ddddd =d;
```

```javascript
var a     = b;
var ab    = c;
var abcd  = d;
var ddddd = d;
```

With more than one selection

```javascript
var a = b;    /* selection 1 */
var ab = c;   /* selection 1 */
var notMePlease='NOOOO';
var abcd = d; /* selection 2 */
var ddddd =d; /* selection 2 */
```

```javascript
var a     = b;
var ab    = c;
var notMePlease='NOOOO';
var abcd  = d;
var ddddd = d;
```

On a single line started with `ctrl+cmd+a`

```javascript
var a = b var cde =   d
```

```javascript
var a = b
var cde = d
```

When working with multiple cursors, the different lines are aligned at the best matching cursor position. In the following example the | shows the cursor position.

```javascript
var a    =b var c|= d
var e c|=   f var g = h
var i c=j var k |= l
```

```javascript
var a    =b var c = d
var e c           = f var g = h
var i c=j var k   = l
```

You can even align multiple matches

```javascript
lets = see = what := happens
a  = a  = b = c : d := e
```

```javascript
lets = see = what      := happens
a    = a   = b = c : d := e
```

## License

MIT © [Andre Lerche](https://github.com/papermoon1978)

MIT © [Simon Paitrault](http://www.freyskeyd.fr)
