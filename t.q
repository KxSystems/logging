s:{-1 "\033[33m",x,"\033[0m";}
t:{-1 "\033[32m",x,"\033[0m";}
.t.e:{if[not value x;-1 x;exit 1]}
s"Levels"
t"Load on module"
.l:use`..log; // Local use, log.q is sibling
.log:.l.createLog[];
t"Print hi"
.log.info "hi";
t"Set lvl to error and print hi in info (expect no-op)"
.log.setlvl `error;
.log.info "hi";
t"Set lvl back to info"
.log.setlvl `info;

s"Variable Printing"
.log.info "hi";
.log.info ("this is one var %s";`foo);
.log.info ("these are two vars %s and %r";`foo;"bar");

s"Formats"
t"Testing syslog - each log increases severity (info -> warn -> error)"
.log.setfmt `syslog;
.log.trace "hi";
.log.info "hi";
.log.warn ("this is one var %s";`foo);
.log.error ("these are two vars %r and %s";`foo;"bar");

t"Testing raw"
.log.setfmt `raw;
.log.info "hi";
.log.info .j.j `date`time`message!(.z.d;.z.t;"hello");

t"Adding own formatter"
.log.addfmt[`whoami;"\r\n $u $a $i $f $m\r\n"];
.log.setfmt `whoami;
.log.info "I am exposed"

t"Reverting back to basic formatter"
.log.setfmt `basic;
.log.info "hi";

t"Expect formats in message to be ignored"
.log.info "this is literal %p";
.log.info ("if I wanted time I could do this: %r";.z.p)

s"qipc"
t"starting q process on port 5000"
\q -p 5000
system "sleep 1";
h:hopen 5000;
.log.add[(h;{x@({-1 reverse x};y)});`info];
t"should print reverse message and original"
.log.info "hello";
.log.remove[h;`info];

s"files"
t"creating a text filehandle"
n:hsym `$(first system "mktemp"),".txt";
f:hopen n;
.log.add[f;`info];
.log.info "line 1";
.log.info "line 2";
.log.remove[f;`info];
hdel n;

t"create binary and append"
n:hsym `$first system "mktemp";
n set "foo\n";
f:hopen n;
.log.add[f;`info];
.log.info "line 1";
.log.info "line 2";
t"showing what's in the file"
-1 value n;
.log.remove[f;`info];
hdel n;

s"edge cases"
t"invalid format"
.log.addfmt[`invalid;"$1 $!\r\n"];
.log.setfmt `invalid;
.log.info "this is invalid";
t"valid message should send after changing back"
.log.setfmt `basic;
.log.info "hi";
t"invalid replacements"
.log.info ("hi %1";`foo);
t"should log normally after fail"
.log.info ("this is one var %r";`foo);
t"using %s on non-character"
.log.info ("this is one var %s";1);

t"escape characters"
.log.addfmt[`escape;"$$10 $m\r\n"];
.log.setfmt `escape;
.log.info "hi";
.log.setfmt `basic;
.log.info "this works 100%";
.log.info ("this works 100%% %r";`foo);

t"set to non-existant format"
.log.setfmt `nexist;
.log.info "hi";

t"test invalid handle expect error"
.log.setfmt `basic;
.log.add[999i;`info];
.log.info "should see 999 dropped";


s"test namespace specific functions"
.l:use`..log;
\d .rdb
logger:.l.createLog[];
f:{logger.trace "trace from rdb f"};
\d .hdb
logger:.l.createLog[];
f:{logger.trace "trace from hdb f";logger.warn "warn from hdb f"};
\d .
t"Run rdb logger - expect no output since trace"
.rdb.f[];
t"Run hdb logger - expect output since warn"
.hdb.f[];
t"Change level for rdb to trace and call - expect output"
.rdb.logger.setlvl `trace;
.rdb.f[];
t"HDB should not log trace as level wasn't set for it"
.hdb.f[];

s"completed tests"
exit 0;
