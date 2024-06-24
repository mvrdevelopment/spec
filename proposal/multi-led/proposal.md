# Proposal for allowing defining non trivial fixture behavior like MultiLED and Macro behavior

## Linked Issues
https://github.com/mvrdevelopment/spec/issues/58
https://github.com/mvrdevelopment/spec/issues/203

## Problem
Fixtures with multiple LED have often have some kind of an effect engine build in, that allows to control the different LEDs, without the need to actually do all the programming on a console pixel by pixel.
A similar thing are fixture macros, that can playback specific effects of a fixture like changing colors and moving patterns.

For all of this behavior it is challenging to previsualize, as the actual behavior is triggered by one or multiple commands, but what actually happens is mostly unclear.

This proposal wants to add an approach to allow to define this behavior in such a way, that it can be visualized.


## Design Goals
- The approach needs to be fast. There could be thousands of devices where this patterns/effects need to be calculated. We need to have in mind that performance is crucial here. This said, it can be acceptable that we only do this for a selected count of devices, while the other are skipped.
- Manufacturers need to be able to provide the information in an easy and testable way. 
- When using the information on a console/visalizer, it needs to be safe and not compromise the running show.
- It need to be portable to different operating systems (Win, Mac, Linux) and architectures(arm, x86, x64).


## Solution

## Generator Modules

The idea that was produced back in 2022 was to add an API to GDTF, that allows to add additional `ChannelFunctions` to the GDTF and then control them via code. 

An sample of such an interface in in the [virtual_fixture.hxx](https://github.com/mvrdevelopment/spec/pull/127/files#diff-da40c861c6a3c4f7ac45148c94c474121411cb38422eb940ed4ca8f390720167) file.

The idea is that manufactures can compile the existing firmware into such an interface and so really can make sure that the visualization matches what the device is doing.

In order for this to work the following assumptions have been made:
1. You need to expose the DMX Data to the code of the fixture (When there are other protocolls that control the device, these also needs to be given.)
1. The geometry tree of the fixture can not be changed, and every Beam Geometry or other geometry that will be changed already needs to be there. 

The basic idea of the proposal is that first, the normal calculation of the `ChannelFunctions` of the GDTF, the `Generator Modules` also defines Attributes and physical values applied to the Geometries of the GDTF.

To entertain this idea you need some kind of code execution. There are currently two proposals:

## Option 1 - WASM / LLVM Code

[WebAssembly](https://webassembly.org)
[emscripten](https://emscripten.org)

Multiple languages like C++, Rust, C#, Kotlin or AssemblyScript (a TypeScript-like syntax) can be compiled to WASM. 
This then can be executed in a virtual machine on the target. WASM code is platform independent. The execution speed can be compared with normal execution. 
Multithreading is possible using POSIX. Vectorization/SIMD is also possible.

The main advantage of approach is, that manufacturers can compile their firmware directly to WASM, as the C/C++ code can be compiled into wasm.

WASM is currently shipped in Firefox, Chrome, Safari and Edge.


## Option 2 - Shader language

An other option is to use shader languages like glsl. 


## Questions
- When using a code approach, we need to think about a way to debug.