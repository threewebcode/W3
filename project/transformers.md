# Transformer

## Data

Each consise data has its own data format and rules. The different section is extracted according to its specific rules. A DataCollator is a function that takes a list of samples from a Dataset and collate them into a batch, as a dictionary of PyTorch/TensorFlow tensors or NumPy arrays.

The function and control flow are utilized to perform computation. The data is processed according to the rule.The memory object is leveraged to hold state daya. Different data processor are added to support different cases. The base class is used as interface template.

The `csv`, `dataclass` and `typing` packages are imported at the head of `util.py` file. The three dots are used to do relative module reference in the grandparent package. The data class is a decorator of annotating the class to be data purpose class. The data file is used to fill all kinds of memory data.
