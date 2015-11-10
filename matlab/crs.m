function crs(t, f, X, depth)

dim = t.dim; hit = 1; sd = 8;
for d = 1:depth
  fprintf('step %d',d);
  t.set_flags('all', sd);           % flag all boxes for subdivision
  t.subdivide(sd);                  % subdivide flagged boxes
  G = tpmatrix(t, f, X, d);         % compute transition matrix/graph
  sc = scc(G,G');                   % strongly connected components of G
  sc(find(sc > -1)) = 1;            % sc == -1 means that the box is not contained in any scc
  sc(find(sc == -1)) = 0;           
  flags = sprintf('%1d', sc); 
  t.set_flags(flags, hit);          % flag boxes which are contained in some scc          
  t.remove(hit);                    % remove flagged boxes
  fprintf('\n');    
end