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

Official list of packages compatible with tagging: https://latex3.github.io/tagging-project/tagging-status/
The list is pessimistic - some packages labeled as incompatible have workarounds or cause only less-than-ideal tagging.
works with an up-to-date version of TeXLive.\
I suspect it won't work with Overleaf (packages too out of date and compilation timeout) - but this has not been tested.



The template has only been tested with MikTeX. It probably 