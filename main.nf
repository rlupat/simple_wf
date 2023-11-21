#!/usr/bin/env nextflow
nextflow.enable.dsl=2

process sayHello {
    publishDir "output"

    input:
        val x
    output:
        path "${x}.txt", emit: out

    script:
        """
        echo '$x world!' > "${x}.txt"
        """
}

process countCharacters {
    input:
        path(x)
    output:
        stdout
    script:
        """
        wc -c $x
        """
}

workflow {
  Channel.of('Bonjour', 'Ciao', 'Hello', 'Hola') | sayHello

  countCharacters(sayHello.out) | view

}