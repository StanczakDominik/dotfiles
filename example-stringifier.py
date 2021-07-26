#!/usr/bin/env python
"""
This file is a custom stringifier for PuDB.
"""


try:
    import astropy.units as u
    HAVE_ASTROPY = 1
except ImportError:
    HAVE_ASTROPY = 0

from pudb.var_view import default_stringifier
def pudb_stringifier(value):
    """
    This is the custom stringifier.

    It returns str(value), unless it take more than a second to compute,
    in which case it falls back to type(value).
    """
    if HAVE_ASTROPY and isinstance(value, u.Quantity):
        if value.unit == value.unit.si:
            return f"{type(value).__name__}({value.dtype}) {value.shape} {value.unit}"
        else:
            return f"{type(value).__name__}({value.dtype}) {value.shape} {value.unit} ({value.unit.si})"
    else:
        return default_stringifier(value)
