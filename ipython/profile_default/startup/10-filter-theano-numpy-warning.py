# as per https://github.com/Theano/Theano/issues/6667

import warnings
for message in [
        "Argument backend_kwargs has not effect in matplotlib.plot_dist",
        "Using a non-tuple sequence for multidimensional indexing is deprecated",
]:
    warnings.filterwarnings("ignore", message=message)
