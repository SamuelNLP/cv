"""
Test prerequisites file
"""

import pytest

from module.util.prerequisites import (
    require,
    require_all_in_all,
    require_all_of_type,
    require_one_in_all,
    require_one_of_types,
    require_type,
    require_type_or_none,
)


def test_require_conditions():
    """
    Test require conditions
    """

    require(1 > 0)
    require_one_in_all([1 > 0, False])
    require_all_in_all([1 > 0, True, "a" + "b" == "ab"])

    with pytest.raises(AssertionError):
        require("a" == "b")


def test_variable_types():
    """
    Test require types
    """

    require_type(1, int)
    require_one_of_types(1, (int, float))
    require_all_of_type([1, 2, 3, 0, 1 + 2], int)
    require_type_or_none(None, str)
    require_type_or_none(21, int)

    with pytest.raises(AssertionError):
        _ = require_type("test", int)
