BEGIN{
    print "Documentation for "ARGV[1]
    print "=================="
}

/^;{3}/{
    print "* "substr($0,3)
}
/^;{4}/{
    print "** "substr($0,4)
}
/^;{5}/{
    print "*** "substr($0,5)
}

/#\|/,/\|#/{
    if($0 ~ /#\|/ || $0 ~ /\|#/){
        skip
    }else{
        print
    }
}
