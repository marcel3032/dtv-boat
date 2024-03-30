import numpy as np


def rotate_points(vA, vB, vC, vD=None):
  x = vB-vA
  y = vC-vA

  M = np.cross(x, y)
  N = np.array([0,0,1])

  costheta = M.dot(N) / (np.linalg.norm(M)*np.linalg.norm(N))
  c = costheta
  s = np.sqrt(1-c*c)
  C = 1-c

  axis = np.cross(M, N)/ np.linalg.norm(np.cross(M, N))

  x,y,z = axis[0], axis[1], axis[2]
  rmat = np.array([[ x*x*C+c  , x*y*C-z*s, x*z*C+y*s ],
                   [ y*x*C+z*s, y*y*C+c  , y*z*C-x*s ],
                   [ z*x*C-y*s, z*y*C+x*s, z*z*C+c   ]])
  
  print('[', ', '.join(map(str, rmat.dot(vA))), ']')
  print('[', ', '.join(map(str, rmat.dot(vB))), ']')
  print('[', ', '.join(map(str, rmat.dot(vC))), ']')
  if vD is not None:
    print('[', ', '.join(map(str, rmat.dot(vD))), ']')
  print()

rotate_points(np.array([3.75, 0, 0]), np.array([17, 0, 0]), np.array([20.5, 6, 2.5]), np.array([2.5, 6, 2.5]))
rotate_points(np.array([24.5, 8, 7.5]), np.array([20.5, 6, 2.5]), np.array([45, 0, 7.5]))
rotate_points(np.array([45, 0, 7.5]), np.array([20.5, 6, 2.5]), np.array([17, 0, 0]))
rotate_points(np.array([24.5, 8, 7.5]), np.array([0, 8, 7.5]), np.array([2.5, 6, 2.5]), np.array([20.5, 6, 2.5]))