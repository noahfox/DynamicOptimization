function cleanup_mess(n)
list = ls('simdat*');
if length(list) > n
    delete(list(1,:));
end