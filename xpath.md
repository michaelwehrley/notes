# XPath

For testing visit [http://www.xpathtester.com/xpath](http://www.xpathtester.com/xpath)

## Predicate Expressions

`/book/chapter[1]` - `[1]` is the predicate expression.

## Select XPath Examples

| Path Expression          | Description                                                  |
|--------------------------|--------------------------------------------------------------|
| `/`                      | Select the root tag in the document.                         |
| `/root_tag`              | Select the root tag named "root_tag."                        |
| `//tag_name`             | Find all "tag_name" elements anywhere in the document.       |
| `text()`                 | Select the text content of the current node.                 |
| `@name`                  | Select the text content of the current node.                 |
| `..`                     | Select the parent of the current node.                       |
| `/book/chapter[6]`       | Select the 6th `chapter` under the `book` tag.               |
| `/body/p[last()]`        | Select the last paragraph tag in the bdoy element.           |
| `/body/p[@class="a"]`    | Select the `p` tags that have a class attribute equal to "a" |
| `//p[@class and @style]` | Select the `p` tags in the doc w/ class and style attributes |

```xml
<?xml version="1.0" encoding="UTF-8"?>

<BusinessCard>
  <Name>Mike Wehrley</Name>
  <phone type="mobile">987.654.3210</phone>
  <phone type="work">123.456.7890</phone>
  <phone>311</phone>
  <email>mike@ex.co</email>
</BusinessCard>
```

## Examples
`//Name` =>
```xml
<Name>Mike Wehrley</Name>
```

`//Name[contains(text(), 'Mike')]` =>
```xml
<Name>Mike Wehrley</Name>
```

`//phone[@type]` =>
```xml
<phone type="mobile">987.654.3210</phone>
<phone type="work">123.456.7890</phone>
```

`//phone[@type="mobile"]` =>
```xml
<phone type="mobile">987.654.3210</phone>
```

`/BusinessCard/phone[contains(text(),"987.654.3210")]`
```xml
<phone type="mobile">987.654.3210</phone>
```

`/BusinessCard/phone[contains(text(),"987.654.3210") or contains(text(),"311")]`
```xml
<phone type="mobile">987.654.3210</phone>
<phone>311</phone>
```

`/BusinessCard/phone[@type='mobile'] and BusinessCard/phone[@type='work']` => `true`

