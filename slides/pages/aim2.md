# Aim 2: A bioinformatics pipeline manager

<v-clicks>

- What is a pipeline?
- Why do we need a pipeline manager?
- What piphany would do for you
- How is piphany different?

</v-clicks>

---

# What is a computational pipeline?

- Any sequence of computational operations that takes inputs and produces outputs

<v-clicks>

```shell
echo "hi there" | sed 's/ there/, world/g' | cowsay
```

```
 ___________
< hi, world >
 -----------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
```

</v-clicks>

---

# How complicated can a pipeline be?

<img src="/nf-core-chipseq.png" width=80%/>

---

# How does a pipeline manager help?

- Organization
- Reproducibility
- Caching
- Portability

---

# Example: No pipeline manager, no version control

- Multiple bash/python/R scripts
- Large computational requirements (memory, compute time)
- An organized person may notate the scripts by their step number or with some
  descriptive name
  - e.g clean-step-1, normalize-step-2, transform-step-3, finish-up-step-4

```mermaid
graph LR;
A["step 1: Clean"]-->B;
B["step 2: Normalize"]-->C;
C["step 3: PCA"]-->D;
D["step 4: Plot"]
```

---

```yaml
transition: none
```

## The consequences

<v-clicks>

- You made a change to step 1 and forgot to rerun the pipeline from the beginning before modifying step 4
- The state of the outputs is now out of sync with the code!
- After realizing this, you find that your change to step 4 is incompatible with step 1!
- You can't revert to a version that worked because you didn't use version control!
- You spend hours debugging and more hours of compute time testing 🙁

</v-clicks>

---

```yaml
transition: none
```

## The consequences

<v-clicks>

- Another lab wants to use your pipeline, but they don't use the same HPC
- They have to make many modifications to get your code to work
- Their results don't look quite the same, but you can't figure out why because they had to make so many modifications to even run your code
- Many hours of both labs' time is lost to solving this problem 🙁

</v-clicks>

---

## The consequences

<v-clicks>

- You weren't very organized at the beginning of the analysis, and haven't looked at the code in a while.
- You've forgotten how your scripts are supposed to connect to each other 😰

</v-clicks>

---

## How does a pipeline manager solve these problems?

- Defines the relationships between computational tasks in a dependency graph

<img src="/why-pipeline-manager.svg"/>

<v-drag-arrow
v-click="[1, 3]"
pos="801,180,-79,71"
v-motion
:click-1="{ x: 0, y: 0 }"
:click-2="{ x: 110 }"
color="red"/>

---

# Portability

- Pipeline managers abstract away HPC specific tools

<img v-drag="[94,220,392,410]" src="/bsub-script.svg" />

<img v-drag="[587,-86,392,410]" src="/slurm-script.svg" />

<img v-drag="[623,211,334,424]" src="/piphany-bsub.svg" />

<v-drag-arrow pos="421,434,158,-1"/>

<v-drag-arrow pos="775,240,1,61"/>

---

# Reproducibility

- Pipeline managers can abstract away usage of containers
- This also makes the pipeline more portable!

```lisp
(define script (file! "myscript.py"))

(process!
	container : "docker://python:alpine3.23"
	container_runtime : "singularity"
	script #<<"""
		{{script}} --say "hello world"
	"""
)
```

---

# Introducing Piphany

<v-clicks>

- Written in rust
- Pipelines are written in scheme with macros for custom syntax
- Caching by default
  - Iterative caching only reruns what is needed
- Parallel by default
- Almost as easy as writing scripts normally

</v-clicks>

---

# What's a hash?

- Equal-length unique identifiers for any amount of data

<img v-drag="[297,140,401,377]" src="/hash.svg"/>

---

## The model

- Files and computational processes are represented as nodes (derivations)
- Nodes are connected together with directed edges, forming a directed acyclic graph (DAG)
- Each node has a unique sha256 hash, calculated from the node's contents and any input nodes' hashes
  - If any node's hash changes, any dependent nodes' hashes would also change

<img v-drag="[302,206,407,328]" src="/model-hash.svg" />

---

# Why Scheme?

- Piphany pipelines are written in scheme, a variant of lisp

```scheme

; (FUNCTION ARGS) => return
(print "hello world") ; => "hello world"
(+ 1 2) ; => 3
```

- Macros extend the language when needed

```scheme
(define x 5)
x ; => 5

(~> 5
	(+ 6)
	(- 3)) ; => 8

```

- Now you know scheme!

Scheme is easily embeddable into a rust program and supports custom syntax,
drastically reducing the development burden of writing a DSL

<img v-drag="[829,56,91,74]" src="/steel.png" />

---

# Pipeline Hello World

<img v-drag="[34,133,452,330]" src="/piphany-hello-world.svg" />

<img v-drag="[531,11,379,321]" src="/code-shots/piphany-hello.svg" />

<img v-drag="[500,343,448,180]" src="/code-shots/piphany-hello-config.svg"/>

---

# Using files in processes

<img v-drag="[30,96,462,437]" src=/code-shots/piphany-hello-file.svg />

<img v-drag="[565,27,349,493]" src="/piphany-files-dag.svg" />

<v-drag-arrow v-click=1 color="red" pos="653,199,6,69"/>
<v-drag-arrow v-click=2 color="orange" pos="926,252,-50,51"/>
<v-drag-arrow v-click=2 color="orange" pos="926,380,-50,51"/>

---

```yaml
layout: two-cols
```

# Other features

- Metadata as polars dataframes

<img v-drag="[532,22,419,402]" src="/code-shots/metadata.svg"/>

```
┌─────┬─────┬─────────────────────────────────┐
│ a   ┆ b   ┆ c                               │
│ --- ┆ --- ┆ ---                             │
│ i64 ┆ i64 ┆ Derivation                      │
╞═════╪═════╪═════════════════════════════════╡
│ 1   ┆ 1   ┆ main.rs-a2327dce5ced50de170443… │
│ 2   ┆ 2   ┆ vm.csv-aafa4ed51de01f59026e07d… │
└─────┴─────┴─────────────────────────────────┘
```

- Test nodes

<img v-drag="[151,269,407,302]" src="/code-shots/test.svg" />

---

# Container Backends

- Containers will run on singularity/apptainer/podman/docker depending on what is available

```scheme
(process!
	name : "docker-hello"
	container : community.wave.seqera.io/library/pip_biopython:f09d93c7760ef5be
	script : #<<"""
	#!/usr/bin/env python
	import biopython
	"""
)
```

- This makes the process reproducible and portable for a variety of systems!

---

# Executor Backends

Different HPCs have different ways to submit jobs

- bsub (LSF)
- sbatch (slurm)
- more eventually

```scheme
;; .piphanyConfig
(config "executor" "LSF")

```

---

# Parameters

The pipeline will support declared and command line parameters

<v-clicks>

- Defined in the config

```scheme
;; .piphanyConfig

(param
	"dataPath"
	PATH ;; param type
	"/data/mydata.csv" ;; default value
)
```

```shell
piphany run --params dataPath /data/other/mydata.csv
```

- usable in the pipeline

```scheme

(define data (file! params.dataPath))

```

- Metadata schema requirements?

</v-clicks>

---

# Error handling philosophy

<v-clicks>

- Each error must have clear steps for resolution
- Small bactraces
- Each error will have a docs page

```scheme
(file! "this/is/my/path")
```

```
Piphany Error[04]: Path does not exist!
  ┌─ :1:2
  │
1 │ (file! "this/is/my/path")
  |  ^^^^^ "this/is/my/path" does not exist! Make sure to specify an existing path
For more info on this error, visit: https://piphany-docs/error04
```

- Rust can guarantee error predictability

</v-clicks>

---

# Ideas

<v-clicks>

- Nix package manager integration
- Process viewer (web based?)
- AWS/Google executor backends
- "doctor" command that checks for environment problems (e.g lack of docker)
- "check" command that checks for reproducibility problems (e.g. absolute paths)
- Process "groups" for caching
- Automatic quoting for interpolations

</v-clicks>

<img v-click="[1, 2]" v-drag="[620,17,315,331]" src="/code-shots/nix-support.svg" />

<!--  LocalWords:  reproducibility
 -->

---

# Comparison to other tools

- Nextflow
- Snakemake
- WDL (Sprocket)

---

# Nextflow

- Most features and compatibility
- Bad error handling
- Separation between code and model
- Caching must be enabled `--resume`
- Reliance on Java and Groovy
- Learning curve stalls adoption
- nf-core is difficult to contribute to

<img v-drag="[434,25,487,80]" src="/nextflow.svg" />

---

# Snakemake

- Relies on plugins for compatibility
- Requires python, making it more difficult to install
- No separation between data and work directories
- Relies on timestamps to realize DAG
- Uses make-style syntax, using wildcards to manage inputs and outputs

<img v-drag="[545,94,397,89]" src="/snakemake.svg" />

---

# WDL (Sprocket)

- Language spec is separate from implementation
- implementation documentation is separate from language documentation
- Sprocket is a St. Jude Children's research hospital initiative
- limited number of executor backends.
  - container + job submitter are a unit (i.e. lsf-apptainer)
- Pipeline language is limited (a pure DSL)
- Caching must be enabled
- Written in rust

<img v-drag="[380,301,781,199]" src="/sprocket-logo-dark.png" />
