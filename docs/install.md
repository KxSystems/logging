# Logging kdb-x installation

[`log.q`](../log.q) is written as a module, under kdb-x's module framework. Though modules can be loaded from anywhere if added to your `$QPATH`, we recommend installing to the `$HOME/.kx/mod/kx` folder. This is to avoid name clashes with other user defined modules, and so KX modules are less pervasive staking a claim on module names (which would become more of an issue when KX releases modules that rely on other KX modules, where the name is assumed).

[`.log.q`](../log.q) depends on the [`printf`](https://github.com/KxSystems/printf) library from KX and assumes it is a sibling of `log.q`

```bash 
export QPATH="$QPATH:$HOME/.kx/mod"
mkdir -p ~/.kx/mod/kx/
cp log.q ~/.kx/mod/kx/
```

Now from anywhere you can import the logging library.

```q
q).logger:use`kx.log;
q).log:.logger.createLog[];
q).log.info "Hello World!";
2025.10.30D11:23:36.826956689 info PID[78061] HOST[a-lptp-p2myzzg4] Hello World!
```

Add the export to your bashrc or equivalent to persist across sessions. 
