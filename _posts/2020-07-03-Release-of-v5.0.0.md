---
title:  "Release of v5.0.0"
tags: 2020, v5
---

The goal of this release is to improve the code quality.
This is a major (and disruptive) update, there are changes in most supervisor codes : scripts **need** to be updated according to these changes.
This is an on-going work in the rc branch of the COMPASS GitLab.

This note will try to summarize all the major changes

## PEP 8 naming convention

Basicaly, it can be summurised like this:

  - class name = CamelCase
  - function and variable names = snake_case

For example:

```python
class MyBeautifulClass:
    def my_favorite_function(self, my_variable_with_explicit_name):
        """ snake_case for functions and variable name
        Explicit names are required : avoid single letter variable for example
        """
```

All names must be explicit, even for temporary variable : avoid single letter variable, acronym, and so on....

It has been already applied to all supervisor classes.
For example, ```applyVoltGetSlopes``` became ```apply_volt_and_get_slopes```
Then, all the function written in camel case has changed, so the scripts which were using it must be adapted also.

This convention is also the baseline for the C++ API.

more info about [PEP8](https://www.python.org/dev/peps/pep-0008/) and [Google C++ Style Guide](https://google.github.io/styleguide/cppguide.html)

## Code documentation

All the class and method must be documented following a Doxygen compatible format.
In the class documentation, attributes of the class must be listed and described :

```python
class MyBeautifulClass:
    """ Brief description of the class

    Detailed description

    Attributes:
        toto: (dict) : toto description

        tata : (float) : tata description
    """

```

In the method documentation, follow the docstring template below:

```python
def my_favorite_function(self, file_path : str, wfs_index : int, 
                         optional_argument : bool=False) -> int:
    """ Brief description of the function

    Detailed description

    Parameters:
        file_path : (str) : parameter description

        wfs_index : (int) : parameter description

        optional_argument : (bool, optional) : parameter description. Default value is False

    Return:
        something : (int) : return description
    """
```

The [typing](https://docs.python.org/3/library/typing.html) python module must be used to also described the variable and return type in function signature, as in the example above.
Respect the docstring template described above, including attention to alinea, line break between parameters...

As COMPASS had become quite huge with time, code documentation will be a long term objective which will require contributions from everyone : do not hesitate to reformat, complete or modify docstrings that do not respect the above rules. We are counting on you all...

For Visual Studio code users, we recommends to use [Doxygen Documentation Generator](https://marketplace.visualstudio.com/items?itemName=cschlosser.doxdocgen). It really useful, it will generate a template based on the function signature. 

[more info](http://www.doxygen.nl/manual/docblocks.html)

## Supervisor modifications

Main developments made for this release, on top of applying the above conventions, aims at supervisor code factorization, as all the contributions (which are welcome) made the code more and more heavy. The goal is to change the current supervisor architecture more modular in order to gain in code readability and maintainability.

This is an on-going work led by Florian. The detailed future architecture is still to be defined.

You can follow here all the modifications made during this work. It will be updated as frequently as possible : 

- PEP 8 application in `shesha.supervisor`
- PEP 8 style in `carma` / `sutra`
- Add CUDA 11 support
- Make MAGMA an optional dependency
- New supervisor architecture using components and optimizers
- Remove `get_centroids` --> becomes `get_slopes`
- Old behavior of `get_slopes` was to call `compute_slopes`, which compute and return. Directly use `compute_slopes` instead
- Remove `get_all_data_loop` functions from `abstractSupervisor` and `AoSupervisor` : unused
- Remove `computeImatModal` from `AoSupervisor` : not used and not implemented
- `set_gain` was able to set mgain also depending on the parameter given. Change the function to be more explicit : `set_gain only` set scalar loop gain while `set_modal_gain` set the modal gain vector
- Rename `set_mgain` to `set_modal_gain`
- Rename get_mgain to `get_modal_gain`
- Remove `write_config_on_file` from `AoSupervisor`, and rename it `getConfigFab` in `canapassSupervisor`
- Rename `set_global_r0` to `set_r0`
- Rename `getIFsparse` to `get_influ_basis` (to make difference with `get_influ`)
- Rename `getIFtt` to `get_tt_influ_basis`
- Rename `getIFdm` to `compute_influ_basis`
- Remove `getTarAmpliPup` (unused)
- Remove `reset` function, use `reset_simu` instead
- Remove `setModalBasis` : unused
- Remove `computePh2ModesFits` : unused
- Rename `setPyrSourceArray` in `set_pyr_modulation_points`
- `set_pyr_modulation` becomes `set_pyr_modulation_ampli`
- Signature changes in `setPyr*Source` : wfs_index first is mandatory
- Add new parameter in PWFS : `p_wfs._pyr_scale_pos` to store the scale applied to `pyr_cx` and `pyr_cy` before upload. Useful for Milan functions
- Rename recordCB in `record_ao_circular_buffer`
- Signature changes for `set_fourier_mask`, `set_noise`, `set_gs_mask` : wfs_index as first argument and mandatory
- Remove `compute_wfs_images` : not used
- Rename `set_dm_shape_from` into `set_command`
- Add new parameter in PDMS : `p_dms[0]._dim_screen` to store the dimension of the DM shape screen
- Add components module : this module defines classes to handle implementation of AO components such as Wfs, Dm, Rtc and so on. For now, only compass implementations are coded, but an abstraction for each component will be developed to allow third party library implementation
- Add optimizers module : this module defines classes to operate on the supervisor components for AO optimization. It could include many algorithms, define in some "thematic" class. For now, it includes `ModalBasis` class (for modal basis computations) and `Calibration` class (for interaction and command matrices). User defined algorithms that do not fit into one of those classes should be written in an other new class with an explicit name to be used by the supervisor.
- Remove `abstractSupervisor`
- Remove `aoSupervisor`
- Remove the simulator module : methods have been moved into the right component
- Add `CONTRIBUTING.md` file to define code guidelines
- Add unit tests for each method accessible from a `compassSupervisor` using pytest. Each contribution should define a new unit test
- Add templates for issue and merge request

Report bugs and issues on [this page](https://github.com/ANR-COMPASS/shesha/issues)
