# StringArt function and stzStringArt class reference

## Introduction

This document provides a comprehensive reference for the `StringArt` function and the `stzStringArt` class, which are used to create and manipulate string art representations of text in the Softanza library.

> NOTE

> If you're not comfortable reading through a complete reference file and prefer building your comprehension of the StringArt features by crafting quick and small code snippets, you can jump now to out our [Softanza StringArt Quickers](../quickers/stzStringArt_Quickers.md) page.

## Quick Reference

| Name | Type | Description | Since | Code | Size | ~> Occurr. | Loops | LoopsInLoops | ExternalCalls | QtBased | Test Level | ~> Occurr. |
|------|------|-------------|-------|------|------|------------|-------|--------------|---------------|---------|------------|------------|
| [StringArt(str)](#stringart) | Function | Creates string art representation of text | V1.0 | Link | Small (-20 LOC) | 6 | 1 | 0 | 4 | YES : QString | 2 : UnitTested + UsedInDoc | 93 |
| [stzStringArt](#stzstringart-class) | Class | Class for creating and manipulating string art | V1.0 | Link | Small (-20 LOC) | 5 | 5 | 1 | 42 | YES : QString | 2 : UnitTested + UsedInDoc | 7 |
| [Content()](#content) | Method | Returns the original content string | V1.0 | Link | Small (-20 LOC)| 2 | 0 | 0 | 0 | NO | 1 : UnitTested | 0 |
| [Style()](#style) | Method | Returns the current string art style | V1.0 | Link | Small (-20 LOC) | 4 | 0 | 0 | 0 | NO | 2 : UnitTested + UsedInDoc | 6 |
| [SetStyle(cStyle)](#setstylecstyle) | Method | Sets the string art style | V1.0 | Link | Small (-20 LOC) | 3 | 0 | 0 | 10 | NO | 2 : UnitTested + UsedInDoc | 4 |
| [Artify()](#artify) | Method | Converts the content to string art representation | V1.0 | Link | Small (-20 LOC) | 3 | 1 | 0 | 8 | NO | 2 : UnitTested + UsedInDoc | 2 |
| [Boxify()](#boxify) | Method | Creates a boxed version of the string art representation | V1.0 | Link | Small (-20 LOC) | 3 | 6 | 1 | 22 | NO | 2 : UnitTested + UsedInDoc | 4 |
| [StringArtStyles()](#stringartstyles) | Function | Returns available string art styles | V1.0 | Link | Small (-20 LOC) | 4 | 1 | 0 | 2 | NO | 2 : UnitTested + UsedInDoc | 1 |
| [IsStringArtStyle(str)](#isstringartstylestr) | Function | Checks if a string is a valid art style | V1.0 | Link | Small (-20 LOC) | 1 | 0 | 0 | 2 | NO | 0 : Nontested! | 0 |
| [DefaultStringArtStyle()](#defaultstringartstyle) | Function | Returns the default string art style | V1.0 | Link | Small (-20 LOC) | 8 | 0 | 0 | 0 | NO | 0 : Nontested! | 0 |
| [SetDefaultStringArtStyle(cStyle)](#setdefaultstringartstylecstyle) | Function | Sets the default string art style | V1.0 | Link | Small (-20 LOC) | 2 | 0 | 0 | 5 | NO | 0 : Untested! | 0 |

## StringArt function

### Basic Information

`StringArt(str)` is a function that creates string art representations of text.

### Details

- Accepts a string as input
- Returns a string art representation of the input
- Uses the default string art style (can be changed using `SetDefaultStringArtStyle`)
- Supports a special syntax for string art paintings: `StringArt("#{PaintingName}")`

### Examples

```ring
load "stzlib.ring"

? StringArt("Hello")
#-->
██░░░██ ███████ ██░░░░░ ██░░░░░ ░▄███▄░
██░░░██ ██░░░░░ ██░░░░░ ██░░░░░ ██▀░▀██
███████ █████░░ ██░░░░░ ██░░░░░ ██░░░██
██░░░██ ██░░░░░ ██░░░░░ ██░░░░░ ██▄░▄██
██░░░██ ███████ ███████ ███████ ░▀███▀░ 
```

```ring
load "stzlib.ring"

? StringArt("#{Tree}")
#-->
    🍃
   🍃🍃
  🍃🍃🍃
 🍃🍃🍃🍃
🍃🍃🍃🍃🍃
    ┃━┃
    ┃━┃
```

### Options

- The default style can be changed using `SetDefaultStringArtStyle(cStyle)`

Example:
```ring
load "stzlib.ring"

SetDefaultStringArtStyle(:neon)
```

### Related Functions

- `StringArtBoxified(str)`: Creates a boxed string art representation
- `CharArtLayers(c)`: Returns a list f strings representing the layers for a single character in string art (used internally by `StringArt()` function)

Example 1:
```ring
load "stzlib.ring"

? StringArtBoxified("HELLO")
#-->
╭─────────────────────────────────────────╮
│ ██░░░██ ███████ ██░░░░░ ██░░░░░ ░▄███▄░ │
│ ██░░░██ ██░░░░░ ██░░░░░ ██░░░░░ ██▀░▀██ │
│ ███████ █████░░ ██░░░░░ ██░░░░░ ██░░░██ │
│ ██░░░██ ██░░░░░ ██░░░░░ ██░░░░░ ██▄░▄██ │
│ ██░░░██ ███████ ███████ ███████ ░▀███▀░ │
╰─────────────────────────────────────────╯
```

Example 2:
```ring
load "stzlib.ring"

? CharArtLayers("R")
#-->
[
	"███▄▄░░",
	"██░░░██",
	"███▄▄░░",
	"██░▀██░",
	"██░░░██"
]
```


## stzStringArt Class

### Basic Information

`stzStringArt` is a class for creating and manipulating string art representations of text.

### Constructor

```ring
load "stzlib.ring"

new stzStringArt(str)
```

- `str`: The input string to be converted to string art

### Public Methods

#### Content()

Returns the original content string.

#### Style()

Returns the current string art style.

Example:
```ring
load "stzlib.ring"

oArt = new stzStringArt("Hi!")
? oArt.Style()
#-->
retro
```

#### SetStyle(cStyle)

Sets the string art style.

- `cStyle`: The name of the style to set (must be a valid style from `StringArtStyles()`)

Example:
```ring
load "stzlib.ring"

oArt = new stzStringArt("Hi!")
oArt.SetStyle(:flower)
? oArt.Style()
#-->
flower
```


#### Artify()

Converts the content to string art representation.

Example:
```ring
load "stzlib.ring"

oArt = new stzStringArt("Ring")

oArt.SetStyle(:flower)
? oArt.Artify()

#-->
.-------.     .-./`)  ,---.   .--.   .-_'''-.   
|  _ _   \    \ .-.') |    \  |  |  '_( )_   \  
| ( ' )  |    / `-' \ |  ,  \ |  | |(_ o _)|  ' 
|(_ o _) /     `-'`'` |  |\_ \|  | . (_,_)/___| 
| (_,_).' __   .---.  |  _( )_\  | |  |  .-----.
|  |\ \  |  |  |   |  | (_ o _)  | '  \  '-   .'
|  | \ `'   /  |   |  |  (_,_)\  |  \  `-'`   | 
|  |  \    /   |   |  |  |    |  |   \        / 
''-'   `'-'    '---'  '--'    '--'    `'-...-'
```


#### Boxify()

Creates a boxed version of the string art representation.

Example:
```ring
load "stzlib.ring"

oArt = new stzStringArt("Ring")

oArt.SetStyle(:flower)
? oArt.Artify()

#-->
╭──────────────────────────────────────────────────╮
│ .-------.     .-./`)  ,---.   .--.   .-_'''-.    │
│ |  _ _   \    \ .-.') |    \  |  |  '_( )_   \   │
│ | ( ' )  |    / `-' \ |  ,  \ |  | |(_ o _)|  '  │
│ |(_ o _) /     `-'`'` |  |\_ \|  | . (_,_)/___|  │
│ | (_,_).' __   .---.  |  _( )_\  | |  |  .-----. │
│ |  |\ \  |  |  |   |  | (_ o _)  | '  \  '-   .' │
│ |  | \ `'   /  |   |  |  (_,_)\  |  \  `-'`   |  │
│ |  |  \    /   |   |  |  |    |  |   \        /  │
│ ''-'   `'-'    '---'  '--'    '--'    `'-...-'   │
╰──────────────────────────────────────────────────╯
```

## Utility Functions

### StringArtStyles()

Returns a list of available string art styles.

Example:
```ring
load "stzlib.ring"

? StringArtStyles()
#-->
[ "retro", "neon", "geo", "flower" ]
```

### IsStringArtStyle(str)

Checks if the given string is a valid string art style.

Example:
```ring
load "stzlib.ring"

? IsStringArtStyle(:flower)
#-->
TRUE
```

### DefaultStringArtStyle()

Returns the current default string art style.

Example:
```ring
load "stzlib.ring"

? DefaultStringArtStyle()
#-->
retro
```

### SetDefaultStringArtStyle(cStyle)

Sets the default string art style.

Example:
```ring
load "stzlib.ring"

SetDefaultStringArtStyle(:geo)
? DefaultStringArtStyle()
#-->
geo
```

## Data File: stkStringArtData.ring

The `stkStringArtData.ring` file (hosted in ../core/data/stkStringArtData.ring) contains the necessary data for StringArt functionality. It defines styles and paintings used by the `StringArt` function and `stzStringArt` class.

### Style Definitions

Styles are defined in the file using the following format:

```ring
$STZ_STRING_ART_STYLE_001 = [
    [ "A" , [
        "░▄███▄░",
        "██▀░▀██",
        "███████",
        "██░░░██",
        "██░░░██"] ],
    [ "B" , [
        "███▄▄░░",
        "██░░░██",
        "███▄▄░░",
        "██░░░██",
        "███▄▄░░"] ],
    // ... more characters
]
```

Each character is associated with an array of strings that represent its string art layers.

The variables containing the styles are gathered in a global list in stzStringArtData:

```ring
$STZ_STR_ART_STYLES_XT = [
    :retro = $STZ_STR_ART_STYLE_001,
    :neon = $STZ_STR_ART_STYLE_002,
    :geo = $STZ_STR_ART_STYLE_003,
    :flower = $STZ_STR_ART_STYLE_004
]
```

Note: If you add a new style, you should also update this list to include your new style.

### Painting Definitions

Paintings are pre-defined string art images, defined in the file like this:

```ring
$STZ_STR_ART_SNIPPERRIFLE =
"   \
 ___\__,_
[________\_____▄▄▄
[_|___|_|_____|---;"

$STZ_STR_ART_GRENADE = 
"   ,-.
  /   \
 /     \
(  ;◯   )
 \     /
  \___/"

$STZ_STR_ART_ROCKETLAUNCHER =
"
  ____
 /    \========[}
<======|________]
 \____/
"
```

These paintings can be accessed using the special syntax `StringArt("#{PaintingName}")`.

To add a new painting, simply add a new variable with a name starting with `$STZ_STR_ART_` and define your string art. The `StringArt("#{...}")` function will automatically recognize it.

Note: This feature is quite flexible. For example, if you add:

```ring
$STZ_STR_ART_MYCUSTOMART = "Your string art content here"
```

You can then use `StringArt("#{my custom art}")` with spaces, and Softanza will automatically concatenate it to match your variable name.


## Note

The "stk" prefix in file names (e.g., **stk**StringArt.ring and **stk**StringArtData.rig), with the "k" representing **SoftanzaCore**, signifies that these components belong to the foundational layer of the Softanza architecture, ensuring their accessibility to all upper levels. Consequently, loading "**stz**lib.ring" at the SoftanzaPrime level will automatically include these core files. However, if desired, you can opt to load only the SoftanzaCore layer by using "load **stk**lib.ring." This approach reduces additional features, streamlines the codebase, and is ideal for constrained environments such as the console, microcontrollers, or web applications.

For more details, see the article: *Overview of the 3 Layers of Softanza Software Architecture* (#TODO: article pending).

## See Also

For a broader understanding of string art support in Softanza, please refer to the article: [An overview of String Art support in Softanza](../overviews/stzStringArt_Overview.md).

For a wide range of practical examples, see the [stzStringArtTest.ring](../../core/test/stkStringArtTest.ring) file.
