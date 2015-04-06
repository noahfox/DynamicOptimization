function make_figs(fig)
global problem
cd('./Results')
for i = 1:length(fig)
    filename = sprintf('p%i_fig%i',problem,i);
    print(filename,'-dpng')
end
    