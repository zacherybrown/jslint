(set -e
printf '> #!/bin/sh
> 
> # Copy jslint files.
> 
> mkdir -p .artifact/
> cp jslint.mjs .artifact/
> cp jslint_wrapper_codemirror.js .artifact/
> 
> # Create static html-page jslint_wrapper_codemirror.html.
> 
> printf '"'"'
> <!DOCTYPE html>
> <html lang="en">
> <head>
>     <title>CodeMirror: JSLint Demo</title>
>     <link rel="stylesheet" href="https://codemirror.net/lib/codemirror.css">
>     <link rel="stylesheet" href="https://codemirror.net/addon/lint/lint.css">
>     <style>
>     body {
>         background: lightgray;
>         color: darkslategray;
>         font-family: sans-serif;
>         margin: 0;
>         padding: 0 20px;
>     }
>     body > * {
>         margin: 20px 0 0 0;
>         padding: 0;
>     }
>     </style>
> </head>
> <body>
>     <h1>CodeMirror: JSLint Demo</h1>
>     <h2>
>         This demo will automatically lint code below,
>         and generate report as you type.
>     </h2>
>     <textarea id="editor1">console.log('"'"'"'"'"'"'"'"'hello world'"'"'"'"'"'"'"'"');</textarea>
>     <div><div id="JSLINT_REPORT_HTML"></div></div>
>     <script defer
>         src="https://codemirror.net/lib/codemirror.js"></script>
>     <script defer
>         src="https://codemirror.net/mode/javascript/javascript.js"></script>
>     <script defer
>         src="https://codemirror.net/addon/lint/lint.js"></script>
>     <script type="module"
>         src="./jslint.mjs?jslint_export_global=1"></script>
>     <script defer
>         src="./jslint_wrapper_codemirror.js"></script>
> <script type=module>
> window.addEventListener("load", function () {
>     let editor = window.CodeMirror.fromTextArea(document.getElementById(
>         "editor1"
>     ), {
>         gutters: ["CodeMirror-lint-markers"],
>         indentUnit: 4,
>         indentWithTabs: false,
>         lineNumbers: true,
>         lint: {
>             lintOnChange: false
>         },
>         mode: "javascript"
>     });
>     function onChange() {
>         let state = editor.state.lint;
>         if (!state) {
>             return;
>         }
>         clearTimeout(state.timeout);
>         state.timeout = setTimeout(function () {
>             editor.performLint();
>             document.getElementById(
>                 "JSLINT_REPORT_HTML"
>             ).outerHTML = window.jslint.jslint_report(window.jslint_result);
>         }, state.options.delay);
>     }
>     editor.on("change", onChange);
>     onChange();
> });
> </script>
> </body>
> </html>
> '"'"' > .artifact/jslint_wrapper_codemirror.html


'
#!/bin/sh

# Copy jslint files.

mkdir -p .artifact/
cp jslint.mjs .artifact/
cp jslint_wrapper_codemirror.js .artifact/

# Create static html-page jslint_wrapper_codemirror.html.

printf '
<!DOCTYPE html>
<html lang="en">
<head>
    <title>CodeMirror: JSLint Demo</title>
    <link rel="stylesheet" href="https://codemirror.net/lib/codemirror.css">
    <link rel="stylesheet" href="https://codemirror.net/addon/lint/lint.css">
    <style>
    body {
        background: lightgray;
        color: darkslategray;
        font-family: sans-serif;
        margin: 0;
        padding: 0 20px;
    }
    body > * {
        margin: 20px 0 0 0;
        padding: 0;
    }
    </style>
</head>
<body>
    <h1>CodeMirror: JSLint Demo</h1>
    <h2>
        This demo will automatically lint code below,
        and generate report as you type.
    </h2>
    <textarea id="editor1">console.log('"'"'hello world'"'"');</textarea>
    <div><div id="JSLINT_REPORT_HTML"></div></div>
    <script defer
        src="https://codemirror.net/lib/codemirror.js"></script>
    <script defer
        src="https://codemirror.net/mode/javascript/javascript.js"></script>
    <script defer
        src="https://codemirror.net/addon/lint/lint.js"></script>
    <script type="module"
        src="./jslint.mjs?jslint_export_global=1"></script>
    <script defer
        src="./jslint_wrapper_codemirror.js"></script>
<script type=module>
window.addEventListener("load", function () {
    let editor = window.CodeMirror.fromTextArea(document.getElementById(
        "editor1"
    ), {
        gutters: ["CodeMirror-lint-markers"],
        indentUnit: 4,
        indentWithTabs: false,
        lineNumbers: true,
        lint: {
            lintOnChange: false
        },
        mode: "javascript"
    });
    function onChange() {
        let state = editor.state.lint;
        if (!state) {
            return;
        }
        clearTimeout(state.timeout);
        state.timeout = setTimeout(function () {
            editor.performLint();
            document.getElementById(
                "JSLINT_REPORT_HTML"
            ).outerHTML = window.jslint.jslint_report(window.jslint_result);
        }, state.options.delay);
    }
    editor.on("change", onChange);
    onChange();
});
</script>
</body>
</html>
' > .artifact/jslint_wrapper_codemirror.html

)
