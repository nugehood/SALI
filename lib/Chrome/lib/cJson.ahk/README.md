
# cJson.ahk

The first and only AutoHotkey JSON library to use embedded compiled C for high
performance.

## Compatibility

This library is compatible with AutoHotkey v1.1 U64 and U32.

Now that AHKv2 is out of Alpha, it's likely that its object structures will not
change significantly again in the future. Compatibility with AHKv2 will require
modification to both the AHK wrapper and the C implementation. Support is
planned, but may not be implemented any time soon.

## Using cJson

Converting an AHK Object to JSON:

```ahk
#Include <JSON>

; Create an object with every supported data type
obj := ["abc", 123, {"true": true, "false": false, "null": ""}, [JSON.true, JSON.false, JSON.null]]

; Convert to JSON
MsgBox, % JSON.Dump(obj) ; Expect: ["abc", 123, {"false": 0, "null": "", "true": 1}, [true, false, null]]
```

Converting JSON to an AHK Object:

```ahk
#Include <JSON>

; Create some JSON
str = ["abc", 123, {"true": 1, "false": 0, "null": ""}, [true, false, null]]
obj := JSON.Load(str)

MsgBox, % obj[1] ; abc
MsgBox, % obj[2] ; 123

MsgBox, % obj[3].true ; 1
MsgBox, % obj[3].false ; 0
MsgBox, % obj[3].null ; *nothing*

MsgBox, % obj[4, 1] ; 1
MsgBox, % obj[4, 2] ; 0
MsgBox, % obj[4, 3] ; *nothing*

; If you set `JSON.BoolsAsInts := false` before calling JSON.Load
;MsgBox, % obj[4, 1] == JSON.True ; 1
;MsgBox, % obj[4, 2] == JSON.False ; 1

; If you set `JSON.NullsAsStrings := false` before calling JSON.Load
;MsgBox, % obj[4, 3] == JSON.Null ; 1
```

## Notes

### Data Types

AutoHotkey does not provide types that uniquely identify all the possible values
that may be encoded or decoded. To work around this problem, cJson provides
magic objects that give you greater control over how things are encoded. By
default, cJson will behave according to the following table:

| Value         | Encodes as | Decodes as    |
|---------------|------------|---------------|
| `true`        | `1`        | `1` *         |
| `false`       | `0`        | `0` *         |
| `null`        | N/A        | `""` *        |
| `0.5` †       | `"0.5"`    | `0.500000`    |
| `0.5+0` †     | `0.500000` | N/A           |
| `JSON.True`   | `true`     | N/A           |
| `JSON.False`  | `false`    | N/A           |
| `JSON.Null`   | `null`     | N/A           |

\* To avoid type data loss when decoding `true` and `false`, the class property
   `JSON.BoolsAsInts` can be set `:= false`. Once set, boolean true and false
   will decode to `JSON.True` and `JSON.False` respectively. Similarly, for
   Nulls `JSON.NullsAsStrings` can be set `:= false`. Once set, null will decode
   to `JSON.Null`.

† Pure floats, as generated by an expression, will encode as floats. Hybrid
  floats that contain a string buffer will encode as strings. Floats hard-coded
  into a script are saved by AHK as hybrid floats. To force encoding as a float,
  perform some redundant operation like adding zero.

### Array Detection

AutoHotkey makes no internal distinction between indexed-sequential arrays and
keyed objects. As a result, this distinction must be chosen heuristically by the
cJson library. If an object contains only sequential integer keys starting at
`1`, it will be rendered as an array. Otherwise, it will be rendered as an
object.

## Roadmap

* Allow changing the indent style for pretty print mode.
* Export differently packaged versions of the library (e.g. JSON, cJson, and
  Jxon) for better compatibility.
* Add methods to extract values from the JSON blob without loading the full
  object into memory.
* Add methods to replace values in the JSON blob without fully parsing and
  reformatting the blob.
* Add a special class to force encoding of indexed arrays as objects.
* Integrate with a future MCLib-hosted COM-based hash-table style object for
  even greater performance.
* AutoHotkey v2 support.

---

## [Download cJson.ahk](https://github.com/G33kDude/cJson.ahk/releases)