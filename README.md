Issues or pull requests are welcome.

Tagging is slow - do the vast majority of the writing in a separate document (with all your usual presets) before copying over for finishing touches.

If using latexmk with tagging activated, it probably overdoes the number of re-runs, which is part of the slowness problem.

Things to keep in mind while drafting:
1. If you need landscape tables/figures, subfigures, or algorithms, there are competing packages to do the same thing. Use the examples/packages used in the template.
2. Biblatex is needed in the template. To prevent any potential problems, you could use it from the start (but biblatex has pretty good backwards-compatibility).
3. If using Tikz, put those in a separate document and use includegraphics. There are more instructions in the template or in the closed issues.
4. For whatever reason the tagging thing doesn't like if you do something like ```$x_\someCommand{whatever}$``` instead of ```$x_{\someCommand{whatever}}$```  (even though both work with standard latex).
Something like ```$x_1$``` (single character) is fine.
5. The template uses LuaLatex. Drafting with pdflatex will usually be fine, but you can also minimize the chance for problems by starting with lualatex if you are comfortable setting up LuaLatex.
6. Alt-text is added to images using ```\includegraphics[alt={alt text here}]{...}```. If you use a recent version of latex, you should be able to add the alt text to includegraphics without any tagging (it does not do anything without tagging, but it also does not break anything). Table markup I would add later once you have transferred to the template.


When you copy over: 
1. Don't overload the preamble - the template already implements the basics. If you don't know what a package/command in your draft's preamble does, the template probably already handles it.
2. Don't take any warning about tagging too seriously until you recompile a few times. 

Official list of packages compatible with tagging: https://latex3.github.io/tagging-project/tagging-status/
The list is pessimistic - some packages labeled as incompatible have workarounds or cause only less-than-ideal tagging.

The template has only been tested with MikTeX and probably works with an up-to-date version of TeXLive/MacTex.
I suspect it won't work with Overleaf, but this has not yet been tested (let me know if you have!).
There are two main problems with Overleaf:
a) As of Spring of 2025, Overleaf's latest version is TexLive 2024, which was probably frozen around March 2024. This version is too old to support tagging table headers.
Soon-ish (as in probably Summer 2025), Overleaf will likely provide TexLive 2025, which will at least support tagging table headers (although the >1 year lag in updates will probably continue to be difficult to accommodate until tagging is fully matured).
b) The compilation timeout on Overleaf is 4 minutes. My thesis at 150 pages with a few figures and too many fonts takes about 2 minutes on my personal hardware. This seems fine, except Overleaf uses latexmk, which actually does multiple runs everytime you run it. While you can adjust the max runs, to have a bibliography without constantly changing the latexmk settings, you would probably have to at least let latexmk do Latex -> Biber -> Latex, which could surpass 4 minutes in a lengthy document with alot going on. Latexmk also throws errors around if you prevent it from doing the re-runs it wants to do, so there would probably be many false flags.
