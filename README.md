# 4IAR-improvements

**Implementation of the cognitive model and improvements described in Kuperwajs, Schütt, and Ma (2023).**

## Approach

This repository implements a model of human planning in 4-in-a-row. The models are fit to human decisions in large-scale data. Model fits and parameters are available upon request, and the neural network code is available at https://github.com/ionatankuperwajs/4IAR-nns. Additionally, more information about the original planning model code is avilable at https://osf.io/n2xjm/.

## File description

Each `Model_code` directory is identical, with the exception of the implemented changes to the specific model improvement. Within each directory, there is a C++ implementation of the model and a Matlab wrapper to do the model fitting with IBS and BADS. The remaining directories are supplementary and do not contain useful information regarding this project. They are in principle used for model fitting and analyses as needed in previous work. The model delineations are as follows, with more information about the changes made to each in the paper:
- `Model code`: baseline planning model adapted from https://github.com/basvanopheusden/fourinarow for large-scale data
- `Model code_1`: opening bias model
- `Model code_2`: defensive weighting model
- `Model code_3`: phantom features model
