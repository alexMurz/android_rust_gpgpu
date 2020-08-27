#![allow(non_snake_case)]

use std::fs::File;
use std::io::{Read, Write};

#[derive(Debug, Ord, PartialOrd, Eq, PartialEq)]
pub enum Type {
    Fragment,
    Vertex,
    Compute,
    NonGlsl
}

extern crate clap;
use clap::{ App, Arg };

pub fn compile_source(source: &str, shader_type: Type) -> Option<Vec<u8>> {
    let ty = match shader_type {
        Type::Vertex => glsl_to_spirv::ShaderType::Vertex,
        Type::Fragment => glsl_to_spirv::ShaderType::Fragment,
        Type::Compute => glsl_to_spirv::ShaderType::Compute,
        _ => return None,
    };

    let mut result = vec![];
    let mut file = glsl_to_spirv::compile(source, ty).expect("Unable to compile");
    file.read_to_end(&mut result).expect("Unable to read result");
    Some(result)
}

pub fn compile_by_dirs(in_dir: &str, out_dir: &str) {

    let cur_dir =  std::env::current_dir().unwrap();
    let in_dir = {
        let mut v = cur_dir.clone();
        v.push(in_dir);
        v
    };
    let out_dir = {
        let mut v = cur_dir.clone();
        v.push(out_dir);
        v
    };

    println!("Working on {:?}", in_dir);
    for f in in_dir.read_dir().unwrap() {
        let f = f.unwrap();
        if f.file_type().unwrap().is_dir() {

            println!("Dir: {:?}", f.path());
        } else {
            let name = f.file_name();

            if name.len() < ".fsh.glsl".len() { continue; }

            let as_str = name.to_str().unwrap();
            let words: Vec<&str> = as_str.split(".").collect();

            match {
                match words.as_slice() {
                    [.., "fsh", "glsl"] => Type::Fragment,
                    [.., "vsh", "glsl"] => Type::Vertex,
                    [.., "cs", "glsl"] => Type::Compute,
                    _ => Type::NonGlsl
                }
            }
            {
                Type::Vertex => {
                    let mut output_file = File::create(
                        format!("{}/{}.vsh.spirv", out_dir.to_str().unwrap(), &as_str[..as_str.len()-9])
                    ).expect("No output file?");

                    print!("Compiling (vertex) {} ... ", as_str);
                    std::io::stdout().flush().unwrap();

                    let mut content = String::new();
                    File::open(f.path()).expect("No input file")
                        .read_to_string(&mut content).expect("Unable to read");
                    let result = compile_source(content.as_str(), Type::Vertex).unwrap();
                    output_file.write(result.as_slice()).expect("Unable to write result");

                    println!("Done!");
                },
                Type::Fragment => {
                    let mut output_file = File::create(
                        format!("{}/{}.fsh.spirv", out_dir.to_str().unwrap(), &as_str[..as_str.len()-9])
                    ).expect("No output file?");

                    print!("Compiling (fragment) {} ... ", as_str);
                    std::io::stdout().flush().unwrap();

                    let mut content = String::new();
                    File::open(f.path()).expect("No input file")
                        .read_to_string(&mut content).expect("Unable to read");
                    let result = compile_source(content.as_str(), Type::Fragment).unwrap();
                    output_file.write(result.as_slice()).expect("Unable to write result");

                    println!("Done!");
                },
                Type::Compute => {
                    let mut output_file = File::create(
                        format!("{}/{}.cs.spirv", out_dir.to_str().unwrap(), &as_str[..as_str.len()-9])
                    ).expect("No output file?");

                    print!("Compiling (compute) {} ... ", as_str);
                    std::io::stdout().flush().unwrap();

                    let mut content = String::new();
                    File::open(f.path()).expect("No input file")
                        .read_to_string(&mut content).expect("Unable to read");
                    let result = compile_source(content.as_str(), Type::Compute).unwrap();
                    output_file.write(result.as_slice()).expect("Unable to write result");

                    println!("Done!");
                }
                _ => (),
            }
        }

    }

}

fn main() {
    let matches = App::new("SPIR-V Shader Compiler")
        .version("0.1")
        .author("Alexei M. <alex_murz@icloud.com>")
        .about("Compiles *.`type`.glsl files into *.`type`.spirv")
        .arg(Arg::with_name("input")
            .short("i")
            .long("input")
            .value_name("DIRECTORY")
            .help("Sets directory for input files")
            .takes_value(true)
            .required(true)
        )
        .arg(Arg::with_name("output")
            .short("o")
            .long("output")
            .value_name("DIRECTORY")
            .help("Sets directory for compiled SPIR-V files")
            .takes_value(true)
        )
        .get_matches();

    let in_dir = matches.value_of("input").unwrap();
    let out_dir = match matches.value_of("output") {
        Some(v) => v,
        None => in_dir,
    };
    compile_by_dirs(in_dir, out_dir)
}
