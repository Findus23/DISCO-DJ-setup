all: requirements-gpu-cuda13.txt requirements-gpu-cuda12.txt requirements-gpu-cuda13_local.txt requirements-gpu-cuda12_local.txt requirements-local-testing.txt


requirements-gpu-cuda13.txt: uv.lock
	uv export --frozen --no-hashes --extra gpu_cuda13 --extra healpix -o requirements-gpu-cuda13.txt --no-emit-package discodj
requirements-gpu-cuda12.txt: uv.lock
	uv export --frozen --no-hashes --extra gpu_cuda12 --extra healpix -o requirements-gpu-cuda12.txt --no-emit-package discodj
requirements-gpu-cuda13_local.txt: uv.lock
	uv export --frozen --no-hashes --extra gpu_cuda13_local --extra healpix -o requirements-gpu-cuda13_local.txt --no-emit-package discodj
requirements-gpu-cuda12_local.txt: uv.lock
	uv export --frozen --no-hashes --extra gpu_cuda12_local --extra healpix -o requirements-gpu-cuda12_local.txt --no-emit-package discodj
requirements-local-testing.txt: uv.lock
	uv export --frozen --no-hashes --extra personal --extra healpix -o requirements-local-testing.txt --no-emit-package discodj
