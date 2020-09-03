---
title:  "Release of v5.0.0"
tags: 2020, v5
---

- PEP 8 application in shesha.supervisor
- PEP 8 style in carma / sutra
- Add CUDA 11 support
- Make MAGMA an optional dependency
- New supervisor architecture using components and optimizers
- Remove get_centroids --> becomes get_slopes
- Old behavior of get_slopes was to call compute_slopes, which compute and return. Directly use compute_slopes instead
- Remove get_all_data_loop functions from abstractSupervisor and AoSupervisor : unused
- Remove computeImatModal from AoSupervisor : not used and not implemented
- set_gain was able to set mgain also depending on the parameter given. Change the function to be more explicit : set_gain only set scalar loop gain while - set_modal_gain set the modal gain vector
- Rename set_mgain to set_modal_gain
- Rename get_mgain to get_modal_gain
- Remove write_config_on_file from AoSupervisor, and rename it getConfigFab in canapassSupervisor
- Rename set_global_r0 to set_r0
- Rename getIFsparse to get_influ_basis (to make difference with get_influ)
- Rename getIFtt to get_tt_influ_basis
- Rename getIFdm to compute_influ_basis
- Remove getTarAmpliPup (unused)
- Remove reset function, use reset_simu instead
- Remove setModalBasis : unused
- Remove computePh2ModesFits : unused
- Rename setPyrSourceArray in set_pyr_modulation_points
- set_pyr_modulation becomes set_pyr_modulation_ampli
- Signature changes in setPyr*Source : wfs_index first is mandatory
- Add new parameter in PWFS : p_wfs._pyr_scale_pos to store the scale applied to pyr_cx and pyr_cy before upload. Useful for Milan functions
- Rename recordCB in record_ao_circular_buffer
- Signature changes for set_fourier_mask, set_noise, set_gs_mask : wfs_index as first argument and mandatory
- Remove compute_wfs_images : not used
- Rename set_dm_shape_from into set_command
- Add new parameter in PDMS : p_dms[0]._dim_screen to store the dimension of the DM shape screen
- Add components module : this module defines classes to handle implementation of AO components such as Wfs, Dm, Rtc and so on. For now, only compass - implementations are coded, but an abstraction for each component will be developed to allow third party library implementation
- Add optimizers module : this module defines classes to operate on the supervisor components for AO optimization. It could include many algorithms, - define in some “thematic” class. For now, it includes ModalBasis class (for modal basis computations) and Calibration class (for interaction and command - matrices). User defined algorithms that do not fit into one of those classes should be written in an other new class with an explicit name to be used by - the supervisor.
- Remove abstractSupervisor
- Remove aoSupervisor
- Remove the simulator module : methods have been moved into the right component
- Add CONTRIBUTING.md file to define code guidelines
- Add unit tests for each method accessible from a compassSupervisor using pytest. Each contribution should define a new unit test
- Add templates for issue and merge request

Report bugs and issues on [this page](https://github.com/ANR-COMPASS/shesha/issues)
