Feature Extraction and Image Processing 
Mark S. Nixon & Alberto S. Aguado
http://www.southampton.ac.uk/~msn/book/
-------------------------------------------------------------------------------
This directory contains python examples

    Images:  The images used in the examples
    Modules: Functions used in the examples

    ExamplesPython_3.12.8: Examples that can be run in the command line or in the 
          visual studio solution (2022) BookExamples.sln

    ExamplesJupyterPyton_3.12.8: Jupyter notebooks examples. LaunchJupyter.bat runs the jupyter IDE

-------------------------------------------------------------------------------
Installation of dependencies:

Examples require python 3.12.8 https://www.python.org/downloads/
	In order to run in visual studio it is necessary to choose tcl/tk and IDLE options during installation

Dependencies can be installed with pip
	Install pip https://www.geeksforgeeks.org/how-to-install-pip-on-windows/
	python -m pip install --upgrade pip

The dependencies are:
	pip install numpy==1.26.4
	pip install pillow==10.4.0
	pip install matplotlib==3.9.2
	pip install pandas==2.2.3

	Other versions may work but they may require change the Modules or examples code

To install jupyter
	python -m pip install jupyter # The examples were developed in version 1.1.1

ML examples require to install tensor flow examples were developed with version 2.17
	pip install tensorflow 
	pip install tensorflow_datasets




