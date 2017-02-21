..
  Technote content.

  See https://developer.lsst.io/docs/rst_styleguide.html
  for a guide to reStructuredText writing.

  Do not put the title, authors or other metadata in this document;
  those are automatically added.

  Use the following syntax for sections:

  Sections
  ========

  and

  Subsections
  -----------

  and

  Subsubsections
  ^^^^^^^^^^^^^^

  To add images, add the image file (png, svg or jpeg preferred) to the
  _static/ directory. The reST syntax for adding the image is

  .. figure:: /_static/filename.ext
     :name: fig-label
     :target: http://target.link/url

     Caption text.

   Run: ``make html`` and ``open _build/html/index.html`` to preview your work.
   See the README at https://github.com/lsst-sqre/lsst-technote-bootstrap or
   this repo's README for more info.

   Feel free to delete this instructional comment.

:tocdepth: 1
.. Please do not modify tocdepth; will be fixed when a new Sphinx theme is shipped.

.. sectnum::

.. Add content below. Do not include the document title.

.. note::

   **This technote is not yet published.**

   This note describes jointcal’s algorithm, fitting process, and currently available models.

Other simlar work
=================

ubercal (from SDSS)
-------------------

ubercal (from Pan-Starrs)
-------------------------

meas_mosaic (from HSC)
----------------------

`meas_mosaic` fits a 7th order Chebyshev polynomial on the focal plane, plus a zero point offset per CCD.
The polynomial coefficients are written to the header of `fcr-[visit]-[ccd].fits` files as `C_N_M` values, while the zero point and its error is written as `FLUXMAG0` and `FLUXMAG0ERR`. That calibration is applied to all of the fluxes in the catalog (converting them to magnitudes in the process).

Jointcal Astrometry
===================

Jointcal Photometry
===================

The only photometric model currently implemented in jointcal is a single zero point per (visit,ccd), which is the same as the current singleFrame processing fit, and thus does not improve the photometry.
The new PhotoCalib object will be used to persist a spatially-variable zero point, and is built on a `~lsst.afw.math.BoundedField`.
The stack already has implemented `~lsst.afw.math.ChebyshevBoundedField`, so we will be able to directly persist an nth-order Chebyshev polynomial and directly compare such a fit to that of `meas_mosaic`.
The key, as with any new model, will be implementing that polynomial in a way that jointcal can fit it. The next step of a new model could be a composite model of a radial polynomial plus a zero point shift per ccd, to account for both ccd-to-ccd variations, and the overall optical system, where radial distortions likely dominate.
