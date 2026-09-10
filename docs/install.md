# Logging kdb-x installation

[`log.q`](../log.q) is written as a module, under KDB-X's module framework. Though modules can be loaded from anywhere if added to your `$QPATH`, we recommend installing under a `kx` folder within your `$QPATH`. This is to avoid name clashes with other user defined modules, as well as providing a name for other KX modules to cross reference each other.

[`.log.q`](../log.q) depends on the [`printf`](https://github.com/KxSystems/printf) library from KX and assumes it is a sibling of `log.q`

## Install module with qmamba

qmamba is a package manager for kdb-x. It is currently available in a private preview capacity. You are welcome to try it and provide feedback.
Follow the install instructions for [qmamba](https://github.com/KxSystems/qmamba/blob/main/README.md#installation).

```q
qmamba:use`kx.qmamba
qmamba.create "myenv"
qmamba.activate "myenv"
qmamba.install `SPECS`CHANNEL!(enlist "q-kx-log";enlist"kx")
.logger:use`kx.log
```

## Installing a Release

It is recommended that a user install this module through a release. 

[Download a release](https://github.com/KxSystems/logging/releases) and then unzip to your module directory. The following example assumes the default install location for KDB-X.

```
unzip logging.zip -d ~/.kx/mod
```

## Installing from Source

```bash
git clone https://github.com/KxSystems/logging.git
cd logging
```

Move `log.q` into your module directory, under `kx`. The following example assumes the default install location for KDB-X.

```bash
mkdir -p ~/.kx/mod/kx
cp log.q ~/.kx/mod/kx/
```


## Next Steps

Now from anywhere you can import the logging library.

If you are using qmamba, you'll first need to activate the environment you installed the logging module
```q
qmamba:use`kx.qmamba
qmamba.activate "myenv"
```

Load the module
```q
q).logger:use`kx.log;
q).log:.logger.createLog[];
q).log.info "Hello World!";
2025.10.30D11:23:36.826956689 info PID[78061] HOST[a-lptp-p2myzzg4] Hello World!
```

You're ready to check out some of the tests we've provided [here](../t.q) and the [reference](reference.md) to get started

