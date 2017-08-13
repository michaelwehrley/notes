# Web Accessibility (a11y)

*a11y* is a _numeronym_ (a number-based word) where _11_ refers to the number of letters omitted from _accessibility_.

People with disabilities can *perceive, understand, navigate, and interact* with the Web, and that they can *contribute* to the Web.

* 1/6 Americans 45 years+ report vision impairment even when wearing glasses or corrective lenses;
* ~8 million persons (age 6 and older) have difficulty seeing words and letters in ordinary newspaper print;
* ~20% of people had a disability in 2010;
* [First website in 1991](http://info.cern.ch/hypertext/WWW/TheProject.html)
* [WebAIM](http://webaim.org/)
* [WebAIM Guidelines & Levels A, AA, AAA](http://webaim.org/standards/wcag/)

## Types of Disabilities

* Attention-Deficit/Hyperactivity Disorders
* Blindness or Low Vision
* Brain Injuries
* Deaf/Hard-of-Hearing
* Learning Disabilities
* Physical Disabilities
* Speech and Language Disabilities

## Assistive Technology

1. Keyboard only (i.e. VIM commands) - *super users*
1. Head want and mouthstick
1. Single switch
1. Screen reader

## Keyboard Navigation (WebAIM 2.1)

_WebAIM 2.1: Make all functionality available from a keyboard_

1. The form at the bottom can’t be submitted with just a keyboard.
1. There is no “skip link” for tabbing straight into the content.
1. [Original Example](./learn-a11y/keyboard-navigation/index.html)
1. [Updated Example](./keyboard-navigation/index.html)

### Shortcuts
* [Google Shortcuts](https://support.google.com/chromebook/answer/183101?hl=en)
* Stick to general browser conventions

Possible shortcuts:
| Open a new tab | Command + t |
| Go to url | Command + l |

### Navigation
* Tabbable: *Shift + Tab* v. *Tab*
  - `<a>`
  - `<button>`
  - `<input>`
  - `<select>`
  - `<textarea>`
  - `<iframe>`
* Tabindex (similar idea as `z-index`):
  ```html
    <div tabindex=“0”>I’m focusable</div>
  ```
  - *Negative* value allows for focusing but not be reachability through keyboard navigation;
  - *0* value allows for focusability and reachability via sequential keyboard navigation in relative order;
  - *Positive* value will add priority to focusability and reachability then relative order follows if equal.

### Visible Focus (WebAIM 2.4.7)
Bootstrap brought this to the forefront with their styling

### Skip Links (WebAIM 2.4.1)

![Skip to navigation example for NYTimes](/assets/skip_links.png)

Output of click: https://www.nytimes.com/?WT.z_jog=1&hF=t&vS=undefined#top-news

These links allow a user to skip over excessive tabbable content:
  * Skip to navigation
  * Skip to comments
  * Skip to content

1. ![Default page displaying main content](/assets/main_content.png)
1. ![Skip to content button highlighted](/assets/skip_to_content.png)
1. ![Main content highlighted after skipping](/assets/main_content_highlighted.png)

Example:
```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Skip Link</title>
    <style>
      .skip-link {
        position: absolute;
        top: -50px; // it is off the screen
        left: 0px;
        background: red;
        color: white;
        padding: 8px;
        z-index: 9999;
      }

      .skip-link:focus {
        top: 10px; // move back into focus
      }
    </style>
  </head>
  <body>
    <a href="#maincontent" class="skip-link">Skip to Content</a>
    <div class="navigation"></div>
    <!-- negative tabindex - not accessible through tabbing
    but in this case through clicking or navigation -->
    <div id="maincontent" tabindex="-1">
      Main Content....
    </div>
  </body>
</html>
```

## Focus (WebAIM 3.1)

*DO NOT* listen to `onfocus` - listen to `onkeyup` or `onclick`.
Happens all the time when people are just tabbing through your site.

```javascript
// Get currently focused item
// Store in memory - refocus after executing functionality like closing methods
var currentElement = document.activeElement;
```

### Tab Trapping / Focus Trapping

1. When the modal appears, you are still able to tab through elements on the main page. Tabbable content should be restricted to the modal.
1. Both hitting the escape key as well as clicking outside the modal should close it.
1. [Original Example](./learn-a11y/focus-control/index.html)
1. [Updated Example](./focus-control/index.html)
1. All focusable [inputs](https://raw.githubusercontent.com/jkup/focusable/master/index.js).

```JavaScript
var elements = modal.querySelectorAll(focusable); // returns an array of all focusable elements
var length = elements.length; // 4
var firstElement = elements[0];
var lastElement = elements[length - 1];
```

Example:
* Select your modal
* [Find](https://github.com/jkup/focusable) and select all focusable children
```JavaScript
  document.querySelectorAll('.markdown-body.entry-content [tabindex="0"], .markdown-body.entry-content a[href]')
```
* Convert them to an array
* Find the first and last tabbable item inside the modal
* Listen for keydown event
* Check to see if it’s the tab key
* *Also check if shift is being held down*: [keycode.info](http://keycode.info/)
* If moving forward and on the last item, focus the first item
* If moving backward and on the first item, focus the last item

## Screen Readers

* Tools: ChromeVox; Command + F5 (on mac)
* Alt text - add to images. An alt text of " " will skip reading; if no value, then it will read src property
* UPPERCASE will read each letter <image alt="MIT" src="./university.png" />
* Hiding: `display:none`; `visibility:hidden`; `<input hidden />`
* labels = use `for=` and `id=`
* [Original Example](./learn-a11y/screen-readers/index.html)
* [Updated Example](./screen-readers/index.html)

### Aria LabelBy
Great for multi part forms
```html
<div id="billing">Billing Address</div>
<div>
  <div id="name">Name</div>
  <input type="text" aria-labelledby="billing name"/>
</div>
<div>
  <div id="address">Address</div>
  <input type="text" aria-labelledby="billing address"/>
</div>
```

### HTML & ARIA Roles

```html
<article role=“article”>Your Content</article>
<!-- HTML 5 semantic versioning will turn into... -->
<div role=“article”>Your Content</div>
```

## Semantic
