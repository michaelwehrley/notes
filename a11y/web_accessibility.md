# Web Accessibility (a11y)

People with disabilities can *perceive, understand, navigate, and interact* with the Web, and that they can *contribute* to the Web.

* 1/6 Americans 45 years+ report vision impairment even when wearing glasses or corrective lenses;
* ~8 million persons (age 6 and older) have difficulty seeing words and letters in ordinary newspaper print;
* ~20% of people had a disability in 2010;
* [First website in 1991](http://info.cern.ch/hypertext/WWW/TheProject.html)

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

## Keyboard

[WebAIM Update Example](./keyboard.md)

### Shortcuts
[Google Shortcuts](https://support.google.com/chromebook/answer/183101?hl=en)
| Open a new tab | Command + t |

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

Example 1:
```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Skip Link</title>
    <style>
      .skip-link {
        position: absolute;
        top: -40px; // it is off the screen
        left: 0;
        background: red;
        color: white;
        padding: 8px;
        z-index: 9999;
      }

      .skip-link:focus {
        top: 0; // move back into focus
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

### Focus (WebAIM 3.2.1)

Happens all the time when people are just tabbing through your site.
Have JS listen to `onkeyup` or `onclick` - not on focus.

Example 2:
[Form Submission](/assets/keyboard.html)
