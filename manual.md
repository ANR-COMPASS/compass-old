---
layout: default
---
# User manual
This is the user manual for COMPASS. We will try to be as exhaustive as possible, but if you don't get the answer you are looking for, [contact us on the project GitHub](https://github.com/anr-compass/shesha).

* blabla
{:toc}

## Quick start
To launch a basic simulation with COMPASS, you can use our script with a parameter file as an argument :
```bash
cd $SHESHA_ROOT
ipython test/closed_loop.py path_to_your_parfile/parfile.py
```
Some basic parameter files are provided in the directory ```$SHESHA_ROOT/data/par/par4bench``` and an example is provided [here](#parameter-file)

After an initialization phase, the script will prompt in the terminal the short exposure Strehl ratio, the long exposure one, an estimation time remaining and the mean framerate of the simulation :
```bash
----------------------------------------------------
| iter# | S.E. SR | L.E. SR | ETR (s) | Framerate (Hz) |
| ----- |
100 	 0.748 	  0.748	     1.3 	 683.2
200 	 0.733 	  0.740	     1.2 	 683.9
300 	 0.742 	  0.741	     1.0 	 683.9
400 	 0.724 	  0.737	     0.9 	 684.1
500 	 0.740 	  0.737	     0.7 	 684.1
600 	 0.789 	  0.746	     0.6 	 684.3
700 	 0.710 	  0.741	     0.4 	 684.3
800 	 0.743 	  0.741	     0.3 	 684.2
900 	 0.696 	  0.736	     0.1 	 684.2
1000 	 0.709 	  0.733	     0.0 	 684.2
 loop execution time: 1.4643762111663818   ( 1000 iterations),  0.0014643762111663818 (mean)   682.8846251220482 Hz
```

## Parameter file
For COMPASS,  a parameter file is a python file where the parameter classes are instantiated and setted to be imported by the simulation script. An example of parameter file follows. All the parameter classes are described in details [here](#parameter-classes).
```python
import shesha_config as conf

simul_name = "scao_sh_40m_80_8pix"

# loop
p_loop = conf.Param_loop()

p_loop.set_niter(5000)
p_loop.set_ittime(0.002)  

# geom
p_geom = conf.Param_geom()

p_geom.set_zenithangle(0.)

# tel
p_tel = conf.Param_tel()

p_tel.set_diam(40.0)
p_tel.set_cobs(0.12)

# atmos
p_atmos = conf.Param_atmos()

p_atmos.set_r0(0.16)
p_atmos.set_nscreens(1)
p_atmos.set_frac([1.0])
p_atmos.set_alt([0.0])
p_atmos.set_windspeed([20.0])
p_atmos.set_winddir([45])
p_atmos.set_L0([1.e5])

# target
p_target = conf.Param_target()

p_target.set_ntargets(1)
p_target.set_xpos([0])
p_target.set_ypos([0.])
p_target.set_Lambda([1.65])
p_target.set_mag([10])

# wfs
p_wfs0 = conf.Param_wfs()
p_wfs1 = conf.Param_wfs()
p_wfss = [p_wfs0]

p_wfs0.set_type("sh")
p_wfs0.set_nxsub(80)
p_wfs0.set_npix(8)
p_wfs0.set_pixsize(0.3)
p_wfs0.set_fracsub(0.8)
p_wfs0.set_xpos(0.)
p_wfs0.set_ypos(0.)
p_wfs0.set_Lambda(0.5)
p_wfs0.set_gsmag(3.)
p_wfs0.set_optthroughput(0.5)
p_wfs0.set_zerop(1.e11)
p_wfs0.set_noise(-1)
p_wfs0.set_atmos_seen(1)

# dm
p_dm0 = conf.Param_dm()
p_dm1 = conf.Param_dm()
p_dms = [p_dm0, p_dm1]
p_dm0.set_type("pzt")
nact = p_wfs0.nxsub + 1
p_dm0.set_nact(nact)
p_dm0.set_alt(0.)
p_dm0.set_thresh(0.3)
p_dm0.set_coupling(0.2)
p_dm0.set_unitpervolt(0.01)
p_dm0.set_push4imat(100.)

p_dm1.set_type("tt")
p_dm1.set_alt(0.)
p_dm1.set_unitpervolt(0.0005)
p_dm1.set_push4imat(10.)

# centroiders
p_centroider0 = conf.Param_centroider()
p_centroiders = [p_centroider0]

p_centroider0.set_nwfs(0)
p_centroider0.set_type("cog")

# controllers
p_controller0 = conf.Param_controller()
p_controllers = [p_controller0]

p_controller0.set_type("ls")
p_controller0.set_nwfs([0])
p_controller0.set_ndm([0, 1])
p_controller0.set_maxcond(1500)
p_controller0.set_delay(1)
p_controller0.set_gain(0.4)
```

## Parameter classes
We describe here all the parameters used in COMPASS and all the classes attributes that could be retrieved by the user during or after the simulation. The following tables give, for each class, the attribute name, a boolean that says if this attribute is settable in the parameters file, its default value and its unit. <span style="color:red"> Parameters displayed in red </span> need to be set by the user in the parameter file if its associated class is instantiated.

### Param_loop

| Attribute name                              | Type  | Units   | Settable | Default | Comments                        |
| :------------------------------------------ | :---- | :------ | :------- | :------ | :------------------------------ |
| <span style="color:red"> **ittime** </span> | float | seconds | required |         | Loop iteration time             |
| **niter**                                   | int   | frames  | yes      | 0       | Number of iterations to perform |
| **devices**                                 | list  | none    | yes      | [0]     | List of GPU devices to use      |

### Param_geom

| Attribute name   | Type  | Units   | Settable | Default | Comments                                                                                        |
| :--------------- | :---- | :------ | :------- | :------ | :---------------------------------------------------------------------------------------------- |
| **pupdiam**      | int   | pixels  | yes      |         | Pupil diameter in pixels                                                                        |
| **zenithangle**  | float | degree  | yes      | 0       | Zenithal angle                                                                                  |
| *_ipupil*        | array | none    | no       |         | Pupil in the full size support                                                                  |
| *_mpupil*        | array | none    | no       |         | Pupil in the medium size support                                                                |
| *_spupil*        | array | none    | no       |         | Pupil in the small size support (equal to pupdiam)                                              |
| *_n*             | int   | pixels  | no       |         | Size of _mpupil support                                                                         |
| *ssize*          | int   | pixels  | no       |         | Size of the _ipupil support                                                                     |
| *_n1*            | int   | pixels  | no       |         | Coordinate of the left side of _mpupil in the _ipupil support                                   |
| *_n2*            | int   | pixels  | no       |         | Coordinate of the left side of _mpupil in the _ipupil support                                   |
| *_p1*            | int   | pixels  | no       |         | Coordinate of the left side of _spupil in the _ipupil support                                   |
| *_p2*            | int   | pixels  | no       |         | Coordinate of the left side of _spupil in the _ipupil support                                   |
| *_cent*          | float | none    | no       |         | Center point of the simulation                                                                  |
| *_phase_ab_M1*   | array | microns | no       |         | Phase aberration in _spupil (will be used if referr, std_piston or std_tt are set in Param_tel) |
| *_phase_ab_M1_m* | array | microns | no       |         | Phase aberration in _mpupil (will be used if referr, std_piston or std_tt are set in Param_tel) |

### Param_tel

| Attribute name                            | Type   | Units         | Settable | Default   | Comments                                                                                                                       |
| :---------------------------------------- | :----- | :------------ | :------- | :-------- | :----------------------------------------------------------------------------------------------------------------------------- |
| <span style="color:red"> **diam** </span> | float  | meters        | required |           | Telescope diameter                                                                                                             |
| **cobs**                                  | float  | ratio of diam | yes      | 0         | Central obstruction size                                                                                                       |
| **type_ap**                               | string | none          | yes      | "generic" | Aperture type available : "generic" (ie. round pupil), "EELT_NOMINAL", "EELT_BP1", "EELT_BP3, "EELT_BP5", "EELT_CUSTOM", "VLT" |
| **spiders_type**                          | string | none          | yes      | None      | Spiders type: "four" or "six"                                                                                                  |
| **t_spiders**                             | float  | ratio of diam | yes      | 0         | Spiders size                                                                                                                   |
| **pupangle**                              | float  | degree        | yes      | 0         | Pupil rotation angle                                                                                                           |
| **nbrmissing**                            | int    | none          | yes      | 0         | Number of missing segments for ELT pupil                                                                                       |
| **referr**                                | float  |               | yes      | 0         | std of reflectivity errors for ELT pupil segments                                                                              |
| **std_piston**                            | float  | microns       | yes      | 0         | std of piston error for ELT pupil segments                                                                                     |
| **std_tt**                                | float  | microns       | yes      | 0         | std of tip-tilt errors for ELT pupil segments                                                                                  |

### Param_atmos

| Attribute name                                 | Type  | Units    | Settable | Default           | Comments                          |
| :--------------------------------------------- | :---- | :------- | :------- | :---------------- | :-------------------------------- |
| <span style="color:red"> **nscreens** </span>  | int   | none     | required |                   | Number of layers                  |
| <span style="color:red"> **r0** </span>        | float | meters   | required |                   | Fried parameters @ 500 nm         |
| <span style="color:red"> **alt** </span>       | list  | meters   | required |                   | Layers altitudes                  |
| <span style="color:red"> **L0** </span>        | list  | meters   | required |                   | Layers outer scale                |
| <span style="color:red"> **frac** </span>      | list  | fraction | required |                   | Layers fraction of r0             |
| <span style="color:red"> **winddir** </span>   | list  | degree   | required |                   | Wind direction for each layer     |
| <span style="color:red"> **windspeed** </span> | list  | m/s      | required |                   | Wind speed for each layer         |
| **seeds**                                      | list  | none     | yes      | 1234+layer indice | RNG seeds for each layer          |
| *_deltax*                                      | list  | pix/iter | no       |                   | X translation speed of each layer |
| *_deltay*                                      | list  | pix/iter | no       |                   | Y translation speed of each layer |
| *_dim_screens*                                 | list  | pixels   | no       |                   | Size of each layer screen         |
| *_pupixsize*                                   | float | meters   | no       |                   | Layer screens pixel size          |

### Param_target

| Attribute name                                | Type  | Units   | Settable | Default | Comments                              |
| :-------------------------------------------- | :---- | :------ | :------- | :------ | :------------------------------------ |
| <span style="color:red"> **ntargets** </span> | int   | none    | required |         | Number of targets                     |
| <span style="color:red"> **Lambda** </span>   | list  | microns | required |         | Wavelength for each target            |
| <span style="color:red"> **xpos** </span>     | list  | arcsec  | required |         | X position of each target in the FoV  |
| <span style="color:red"> **ypos** </span>     | list  | arcsec  | required |         | Y position of each target in the FoV  |
| <span style="color:red"> **mag** </span>      | list  |         | required |         | Magnitude of each target              |
| **zerop**                                     | float | degree  | yes      | 1       | Flux for magnitude 0                  |
| **dms_seens**                                 | list  | none    | yes      | all DMs | List of DM indices seen by the target |

