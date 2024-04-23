
# Rubik's Cube Solver

This project provides a Prolog implementation of a Rubik's Cube solver. It uses a human approach to solve the cube in stages, and it also includes an implementation of the Iterative Deepening Depth-First Search (IDDFS) algorithm.

## Files

- `id.pl`: This file contains the implementation of the IDDFS algorithm to solve the Rubik's cube.
- `human.pl`: This file contains the implementation of a human approach to solve the Rubik's cube.
- `examples.pl`: This file contains examples of Rubik's cube states used for testing.
- `cube.pl`: This file contains the implementation of the Rubik's cube data structure.
- `moves.pl`: This file contains the implementation of the basic moves used to manipulate the Rubik's cube.
- `moves_compound.pl`: This file contains the compound moves used in the human approach to solve the cube.
- `cube_states.pl`: This file contains the predefined cube states used in the human approach to solve the cube.


## Usage

Move to the directory containing all the files, load your [Prolog interpreter](http://www.swi-prolog.org/), and load just the `human.pl` file using the following command:

```prolog
?- ['human.pl'].
```

### Human Approach

To solve a Rubik's cube using the human approach, call the `solve_human/1` function with the initial state of the cube as an argument. The function will print the solution to the console.

For example, to solve the cube with the initial state defined in the `examples.pl` file, use the following command:

```prolog
?- solve_human(in3).
```

### IDDFS Algorithm
To solve a Rubik's cube using the IDDFS algorithm, call the `solve_id/1` function with the initial state of the cube as an argument. The function will print the solution to the console.

For example, to solve the cube with the initial state defined in the `examples.pl` file, use the following command:

```prolog
?- solve_id(in3).
```

### Measuring Time

If you want to see, what amount of time does the particular algorithm take to solve the cube, you can use the `measure_time/3` predicate. It will print the time in minutes and seconds.

```
?- measure_time(solve_id(in6), Minutes, Seconds). 
Starting iterative deepening search...
For the initial state: cube(r,w,o,r,w,o,r,g,b,y,y,y,b,g,g,y,r,o,b,r,y,y,r,y,w,b,r,o,w,w,o,b,g,w,b,g,b,r,g,w,o,w,w,g,g,g,y,b,b,y,o,o,o,r)
Solution found: [Right',Down,Left,Front',Up,Up]
Minutes = 0,
Seconds = 1
```

## Representation of the Cube

The Rubik's cube is represented as a list of 54 elements, where each element represents a 'sticker' on the cube. The stickers are represented by the following colors:

- `b`: Blue
- `g`: Green
- `r`: Red
- `o`: Orange
- `y`: Yellow
- `w`: White

The faces of the cube are then defined as follows:

    ```
        [1, 2, 3]
        [4, 5, 6]
        [7, 8, 9]
    [10,11,12][19,20,21][28,29,30][37,38,39]
    [13,14,15][22,23,24][31,32,33][40,41,42]
    [16,17,18][25,26,27][34,35,36][43,44,45]
        [46,47,48]
        [49,50,51]
        [52,53,54]
    ```

which means, the order of faces is: `Up, Left, Front, Right, Back, Down`, and order of stickers on each face is from left to right and from top to bottom.

The colours of solved cube's faces (and middle stickers at the beginning of solving) using the same orientation of the cube while solving are in this order: `White, Green, Red, Blue, Orange, Yellow`.


## Examples of Cube States

The `examples.pl` file contains examples of Rubik's cube states that can be used for testing. The states are defined as atoms with the prefix `in` followed by a number from `1` to `9` resulting into eg. `in4`. 
The digit 1 to 9 represents the number of moves needed to solve the cube from the initial state.

There are also other predefined states in the `examples.pl` file, which can be used for testing.


## Comparison of Approaches

### Human Approach

The human approach to solving the Rubik's cube is based on the method used by humans to solve the cube. It involves solving the cube in stages, starting with the white cross, then the corners of the bottom face, followed by the middle layer and finally the top face.

The human approach is intuitive and easy to understand, but it may not always be the most efficient way to solve the cube. But it will always find a solution in a reasonable time for any cube state.

### IDDFS Algorithm

The IDDFS algorithm is a brute-force search algorithm that explores all possible states of the cube until it finds a solution. It uses an iterative deepening depth-first search to find the shortest path to the goal state.

The IDDFS algorithm is guaranteed to find a solution if one exists and consist of minimum number of moves. But it may take a longer time to find the solution for complex cube states. 

For comparison with usual BFS, the IDDFS algorithm is more memory efficient, because it doesn't need to store all the states in memory, but only the current path. It is able to solve the cube with a depth of 7 under 15 seconds, 8 moves under 3 minutes and 9 moves under an hour.

#### Why IDDFS?

Let's compare the IDDFS algorithm with the usual BFS and DFS algorithms, where `b` is the branching factor and `d` is the depth of the solution.

            Memory      Time
    BFS:    O(b^d)      O(b^d)
    DFS:    O(d)        up to infinity
    IDDFS   O(d)        O(b^(d+1))

The IDDFS algorithm combines the advantages of both BFS and DFS. It has a memory complexity similar to DFS and a time complexity similar to BFS. It is more memory efficient than BFS and more time efficient than DFS for solving the Rubik's cube.


## References

- [Rubik's Cube Notation](https://youtu.be/24eHm4ri8WM)

- [Iterative Deepening Depth-First Search](https://www.geeksforgeeks.org/iterative-deepening-searchids-iterative-deepening-depth-first-searchiddfs/)

- [Human approach to solve the Rubik's Cube](https://ruwix.com/the-rubiks-cube/how-to-solve-the-rubiks-cube-beginners-method/)

