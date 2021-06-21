# synner.vim

> You look at me, but you don't see  
> Understand, I'm a sinner  
> Don't corner me, don't lecture me  
> Raise your hand if you're a sinner

Inspired by
[2html.vim](https://github.com/vim/vim/blob/master/runtime/syntax/2html.vim),
synner loops over each character in the current buffer to find the highlight
group through `synID` and `synIDattr`, and outputs the results to a parsable
format. Synner could be used to create a syntax highlighter based on Vim's
highlight groups, if somebody would ever think of that.

## Format

Synner prints one line per highlight group, with the group's name, a single
space, and the characters that belong to that group:

    [IDENTIFIER]([SPACE][CONTENTS])

For newlines, the space and contents are omitted.

## Usage

Given a source file:

``` rust
fn main() {
    println!("Hello, world!");
}
```

When I source synner:

    :source ~/path/to/synner.vim

Then synner prints the highlight group representation:

    rustKeyword fn
    Normal  
    rustFuncName main
    Normal () {
    NewLine
    Normal     
    rustMacro println!
    Normal (
    rustStringDelimiter "
    rustString Hello, world!
    rustStringDelimiter "
    Normal );
    NewLine
    Normal }
    NewLine

To use synner from outside of Vim in Ex mode, redirect its output to
`/dev/stdout`:

    $ vim -E -s -c 'redir! > /dev/stdout' -c 'source ~/path/to/synner.vim' -cqa src/main.rs
    
    rustKeyword fn
    Normal  
    rustFuncName main
    Normal () {
    NewLine
    Normal     
    rustMacro println!
    Normal (
    rustStringDelimiter "
    rustString Hello, world!
    rustStringDelimiter "
    Normal );
    NewLine
    Normal }
    NewLine
