function x = stateTransitionFnc(x, u)

rotMat = 0.01/2*[-x(2), -x(3), -x(4);
                  x(1), -x(4),  x(3);
                  x(4),  x(1), -x(2);
                 -x(3),  x(2),  x(1)];

x = x + rotMat*[u(1), u(2), u(3)]';

x = x./norm(x);

end