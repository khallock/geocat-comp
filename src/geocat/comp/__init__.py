from . import _ncomp
import numpy as np
import xarray as xr
from dask.array.core import map_blocks

def linint2(fi, xo, yo, icycx, xmsg=None, iopt=0, meta=False):
    if xmsg is None:
        xmsg = _ncomp.dtype_default_fill[fi.dtype]

    xi = fi.coords[fi.dims[-1]].values
    yi = fi.coords[fi.dims[-2]].values
    fi_data = fi.data
    fo_chunks = list(fi.chunks)
    fo_chunks[-2:] = (yo.shape, xo.shape)
    fo = map_blocks(_ncomp._linint2, xi, yi, fi_data, xo, yo, icycx, xmsg, iopt, chunks=fo_chunks, dtype=fi.dtype, drop_axis=[fi.ndim-2, fi.ndim-1], new_axis=[fi.ndim-2, fi.ndim-1])

    result = fo.compute()

    if meta:
        coords = {k:v if k not in fi.dims[-2:] else (xo if k == fi.dims[-1] else yo) for (k, v) in fi.coords.items()}
        result = xr.DataArray(result, attrs=fi.attrs, dims=fi.dims, coords=coords)
    else:
        result = xr.DataArray(result)

    return result


@xr.register_dataarray_accessor('ncomp')
class Ncomp(object):
    def __init__(self, xarray_obj):
        self._obj = xarray_obj

    def linint2(self, xo, yo, icycx, xmsg=None, iopt=0, meta=False):
        return linint2(self._obj, xo, yo, icycx, xmsg, iopt, meta)
