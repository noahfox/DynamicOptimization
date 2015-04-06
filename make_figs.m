function make_figs(fig)
global problem
mkdir('Results')
cd('./Results')
for i = 1:length(fig)
    filename = sprintf('p%i_fig%i',problem,i);
    print(filename,'-dpng')
end
dat_name = sprintf('results_%i.mat',problem);
save(dat_name)
cd('../')
    