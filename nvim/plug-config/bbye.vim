nnoremap <expr> <C-w> len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) > 1 ? ':Bdelete<CR>' : ':q<CR>'
nnoremap <leader>bd :Bdelete<CR>
nnoremap <leader>bw :Bwipeout<CR>
