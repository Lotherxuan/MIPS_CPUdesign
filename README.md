# MIPS-CPU-DESIGN

This repository is a simple implement of single cycle cpu and a 5-stage pipeline cpu.

Besides, this repository is also the finally class design of the lesson computer organization and design in Wuhan University, in 2019 Autumn.  If you are someone who takes this lesson, you can use this repo as a reference. Hope you'll get good grades in this lesson :smile:

## Table of Contents
  - [Table of Contents](#table-of-contents)
  - [File Tree](#file-tree)
  - [Environment](#environment)
  - [Usage](#usage)
  - [Contributing](#contributing)
  - [License](#license)

## File Tree

The file tree is as followed:

```shell
│  .gitignore       
│  LICENSE
│  实验报告.pdf     
│  
├─Pipeline
│      ALU.v        
│      CONTROL.v    
│      ENCODE.v     
│      EXT.v
│      EX_MEM.v
│      FORWARD.v
│      HARZARD.v
│      ID_EX.v
│      IF_ID.v
│      IM.v
│      MEM.v
│      MEM_WB.v
│      MIPS.v
│      MUX.v
│      NPC.v
│      PC.v
│      RF.v
│      TEST_MIPS.v
│
├─SingleCycle
│      ALU.v
│      CONTROL.v
│      ENCODE.v
│      EXT.v
│      IM.v
│      MEM.v
│      MIPS.v
│      MUX.v
│      NPC.v
│      PC.v
│      RF.v
│      TEST_MIPS.v
│
└─test_codes
        extendedtest.asm
        extendedtest.dat
        mipstestloopjal_sim.asm
        mipstestloopjal_sim.dat
        mipstestloop_sim.asm
        mipstestloop_sim.dat
        mipstest_extloop.asm
        mipstest_extloop.dat
        mipstest_pipelinedloop.asm
        mipstest_pipelinedloop.dat
```

The folders `Pipeline` and `SingleCycle` only contain verilog source code, and **NOT** contain files that related to modelsim project file. The folder `test_codes` contains assembly codes that used to test the cpu.

## Environment  

Editor: VScode 1.45.1

Experiment: ModelSim SE 10.4

Simulator: Mars 4.5

## Usage

You can use this repo as a reference, or something that helps you start your first step on making a cpu. But I strongly recommend you **NOT** simply copy the code. I believe this will make you feel difficult writing your report on this experiment, and you won't get good grades on this lesson.

For more specific usages and the detailed design of cpu, you can dive into `实验报告.pdf`

## Contributing

This project is mainly contributed by following people:

<a href="graphs/contributors"><img src="https://avatars2.githubusercontent.com/u/46411367?s=400&u=dcc5589c8c4935c962c8bc5fc42249d24000829b&v=4" width="100px"/></a> [Lotherxuan](https://github.com/Lotherxuan)

## License

[GNU License](https://www.gnu.org/licenses/gpl-3.0.html)

Copyright © Luo Yuxuan