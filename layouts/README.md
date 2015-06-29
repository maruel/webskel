# Layout files

These files contain the actual layout of your website. Here's the important
references if you desire to hack on them:
  - Hugo templating system:
    - https://gohugo.io/templates/variables/
    - https://gohugo.io/templates/functions/
    - I found using {{ . | printf "%#v" }} then looking up
      http://godoc.org/github.com/spf13/hugo/hugolib to be occasionally useful.
  - Bootstrap styling: http://getbootstrap.com/css/
    - This page is a bit of a OMG such-a-dump but if you ignore the "Less"
      parts, it's almost readable.
    - https://bootswatch.com offers a many nice free Bootstrap templates.
