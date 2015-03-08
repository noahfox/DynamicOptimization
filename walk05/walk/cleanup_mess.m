function cleanup_mess(n)
list = ls('d-*');
if length(list) > n
    delete(list(1,:));
end