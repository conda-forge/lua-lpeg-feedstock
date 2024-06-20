#!/usr/bin/env bash

set -o xtrace -o nounset -o pipefail -o errexit

#luarocks --tree ${PREFIX} build --lua-dir ${BUILD_PREFIX} --lua-version=5.1 --deps-mode=one --no-manifest lpeg-${PKG_VERSION}-1.rockspec CC=${CC} LD=${CC}

DLLFLAGS=""
if [[ ${target_platform} =~ .*osx.* ]]; then
    DLLFLAGS="-Wl,-undefined,dynamic_lookup"
fi

make LUADIR=${BUILD_PREFIX}/include/luajit-2.1 DLLFLAGS="${DLLFLAGS} -shared -fPIC" lpeg.so
mkdir -p ${PREFIX}/lib/lua/5.1
install -m 644 lpeg.so ${PREFIX}/lib/lua/5.1
ln -sf ${PREFIX}/lib/lua/5.1/lpeg.so ${PREFIX}/lib/liblpeg${SHLIB_EXT} 

mkdir -p ${PREFIX}/share/lua/5.1
install -m 644 re.lua ${PREFIX}/share/lua/5.1
install -m 644 test.lua ${PREFIX}/share/lua/5.1
