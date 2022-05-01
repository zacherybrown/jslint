(set -e
printf '> #!/bin/sh
> 
> # 1. Download and save jslint.mjs, jslint_wrapper_codemirror.js to file:
> 
> mkdir -p .artifact/
> curl -Ls https://www.jslint.com/jslint.mjs > .artifact/jslint.mjs
> curl -Ls https://www.jslint.com/jslint_wrapper_codemirror.js \\
>     > .artifact/jslint_wrapper_codemirror.js
> 
> # 2. Create and serve static html-page below:
> 
> printf '"'"'
> <!DOCTYPE html>
> <head>
>     <link rel="stylesheet" href="https://codemirror.net/lib/codemirror.css">
>     <link rel="stylesheet" href="https://codemirror.net/addon/lint/lint.css">
>     <script defer src="https://codemirror.net/lib/codemirror.js"></script>
>     <script defer
>         src="https://codemirror.net/mode/javascript/javascript.js"></script>
>     <script defer src="https://codemirror.net/addon/lint/lint.js"></script>
>     <script type="module" src="./jslint.mjs?window_jslint=1"></script>
>     <script defer src="./jslint_wrapper_codemirror.js"></script>
> </head>
> <body style="background:#bbb; font-family:sans-serif; margin:0; padding:20px;">
>     <h1>CodeMirror: JSLint Demo</h1>
>     <h3>
> This demo will auto-lint the code below, and auto-generate a report as you type.
>     </h3>
>     <textarea id="editor1">console.log(&apos;hello world&apos;);</textarea>
>     <div style="margin-top:20px;"><div id="JSLINT_REPORT_HTML"></div></div>
> <script type=module>
> window.addEventListener("load", function () {
>     let editor = window.CodeMirror.fromTextArea(document.getElementById(
>         "editor1"
>     ), {
>         gutters: ["CodeMirror-lint-markers"],
>         indentUnit: 4,
>         lineNumbers: true,
>         lint: {lintOnChange: false},
>         mode: "javascript"
>     });
>     function onChange() {
>         clearTimeout(editor.state.lint.timeout);
>         editor.state.lint.timeout = setTimeout(function () {
>             editor.performLint();
>             document.getElementById(
>                 "JSLINT_REPORT_HTML"
>             ).outerHTML = window.jslint.jslint_report(window.jslint_result);
>         }, editor.state.lint.options.delay);
>     }
>     editor.on("change", onChange);
>     onChange();
> });
> </script>
> </body>
> '"'"' > .artifact/jslint_wrapper_codemirror.html


'
#!/bin/sh

# 1. Download and save jslint.mjs, jslint_wrapper_codemirror.js to file:

mkdir -p .artifact/
cat jslint.mjs > .artifact/jslint.mjs
cat jslint_wrapper_codemirror.js \
    > .artifact/jslint_wrapper_codemirror.js

# 2. Create and serve static html-page below:

printf '
<!DOCTYPE html>
<head>
    <link rel="stylesheet" href="https://codemirror.net/lib/codemirror.css">
    <link rel="stylesheet" href="https://codemirror.net/addon/lint/lint.css">
    <script defer src="https://codemirror.net/lib/codemirror.js"></script>
    <script defer
        src="https://codemirror.net/mode/javascript/javascript.js"></script>
    <script defer src="https://codemirror.net/addon/lint/lint.js"></script>
    <script type="module" src="./jslint.mjs?window_jslint=1"></script>
    <script defer src="./jslint_wrapper_codemirror.js"></script>
</head>
<body style="background:#bbb; font-family:sans-serif; margin:0; padding:20px;">
    <h1>CodeMirror: JSLint Demo</h1>
    <h3>
This demo will auto-lint the code below, and auto-generate a report as you type.
    </h3>
    <textarea id="editor1">console.log(&apos;hello world&apos;);</textarea>
    <div style="margin-top:20px;"><div id="JSLINT_REPORT_HTML"></div></div>
<script type=module>
window.addEventListener("load", function () {
    let editor = window.CodeMirror.fromTextArea(document.getElementById(
        "editor1"
    ), {
        gutters: ["CodeMirror-lint-markers"],
        indentUnit: 4,
        lineNumbers: true,
        lint: {lintOnChange: false},
        mode: "javascript"
    });
    function onChange() {
        clearTimeout(editor.state.lint.timeout);
        editor.state.lint.timeout = setTimeout(function () {
            editor.performLint();
            document.getElementById(
                "JSLINT_REPORT_HTML"
            ).outerHTML = window.jslint.jslint_report(window.jslint_result);
        }, editor.state.lint.options.delay);
    }
    editor.on("change", onChange);
    onChange();
});
</script>
</body>
' > .artifact/jslint_wrapper_codemirror.html

)
