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

- You made a change to step 1 and forgot to rerun the pipeline from the beginning before modifying step 4
  - The state of the outputs is now out of sync with the code!
  - After realizing this, you find that your change to step 4 is incompatible with step 1!
  - You can't revert to a version that worked because you didn't use version control!
  - You spend hours debugging and more hours of compute time testing 🙁

---

```yaml
transition: none
```

## The consequences

- Another lab wants to use your pipeline, but they don't use the same HPC
  - They have to make many modifications to get your code to work
  - Their results don't look quite the same, but you can't figure out why because they had to make so many modifications to even run your code
  - Many hours of both labs' time is lost to solving this problem 🙁

---

## The consequences

- You weren't very organized at the beginning of the analysis, and haven't looked at the code in a while.
  - You've forgotten how your scripts are supposed to connect to each other 😰

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

<img v-drag="[604,-89,392,410]" src="/slurm-script.svg" />

<img v-drag="[626,215,334,424]" src="/piphany-bsub.svg" />

<v-drag-arrow pos="421,434,158,-1"/>

<v-drag-arrow pos="421,434,158,-1"/>

---

# Reproducibility

- Pipeline managers can abstract away usage of containers
- This also makes the pipeline more portable!

```lisp
(define script (file! "myscript.py"))

(process!
	container : "docker://python:alpine3.23"
	container_runtime : "singularity"
	script #<"""
		{{script}} --say "hello world"
	"""
)
```

---

# Introducing Piphany

- Written in rust
- Pipelines are written in scheme with macros for custom syntax
- Polars dataframes for metadata
- Caching by default
  - Iterative caching only reruns what is needed
- Parallel by default
- Almost as easy as writing scripts normally

---

## The model

- Files and computational processes are represented as nodes (derivations)
- Nodes are connected together with directed edges, forming a directed acyclic graph (DAG)
- Each node has a unique sha256 hash, calculated from the node's contents and any input nodes' hashes
  - If any node's hash changes, any dependent nodes' hashes would also change

---

# Pipeline Hello World

<img v-drag="[34,133,452,330]" src="/piphany-hello-world.svg" />

<img v-drag="[558,150,327,268]" src="/code-shots/piphany-hello.svg" />
