# TokenSpot

## Safe Unlock Algorithm
This project implements an algorithm for finding a path to unlock a lock with numeric states. Input data is read from a file, and the task is to find a path from the initial state to the target state while avoiding restricted states.

## How it works

- **Initial state**: Given as a list of digits.
- **Target state**: Given as a list of digits to reach.
- **Restricted states**: Given as a list of states that cannot be visited.

The algorithm iterates over all possible states, starting from the initial one, and applies operations (increment or decrement digits). It continues until it finds a path to the target state, avoiding the restricted states.

## Project Structure

- `crypto.rb`: The main algorithm code.
- `input.txt`: Example input data.
- `README.md`: This file.

## Installation

Ruby version 2.0 or higher is required to run the project.

1. Download or clone the repository.
2. Ensure that Ruby is installed on your machine.
3. Run the script using the following command:

   ```bash
   ruby crypto.rb

## Input Data Format

The input data should be provided in the input.txt file in the following format:
  ```
  N
  [initial_state]
  [target_state]
  [[restricted_state_1], [restricted_state_2], ...]
  ```
