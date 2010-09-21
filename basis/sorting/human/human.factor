! Copyright (C) 2008, 2010 Doug Coleman, Slava Pestov.
! See http://factorcode.org/license.txt for BSD license.
USING: accessors fry kernel make math math.order math.parser
sequences sorting.functor strings unicode.case
unicode.categories unicode.collation ;
IN: sorting.human

: cut-find ( seq pred -- before after )
    [ drop ] [ find drop ] 2bi dup [ cut ] when ; inline

: cut3 ( seq pred -- first mid last )
    [ cut-find ] keep [ not ] compose cut-find ; inline

: find-sequences ( sequence pred quot -- seq )
    '[
        [
            _ cut3 [
                [ , ]
                [ [ @ , ] when* ] bi*
            ] dip dup
        ] loop drop
    ] { } make ; inline

: find-numbers ( seq -- newseq )
    [ digit? ] [ string>number ] find-sequences ;

! For comparing integers or sequences
TUPLE: hybrid obj ;

: <hybrid> ( obj -- hybrid )
    hybrid new
        swap >>obj ; inline

: <hybrid-insensitive> ( obj -- hybrid )
    hybrid new
        swap dup string? [ w/collation-key ] when >>obj ; inline

M: hybrid <=>
    [ obj>> ] bi@
    2dup [ integer? ] bi@ xor [
        drop integer? +lt+ +gt+ ?
    ] [
        <=>
    ] if ;

<< "human" [ find-numbers [ <hybrid> ] map ] define-sorting >>
<< "humani" [ find-numbers [ <hybrid-insensitive> ] map ] define-sorting >>
