# TABS
		addi		$v0,	$0,			5		# $v0(2)=5
		addi		$v1,	$0,			12 		# $v1(3)=12
		addi		$a3,	$v1,		-9 		# $a3(7)=$v1(3)(12)-9=3
		or			$a0,	$a3,		$v0		# $a0(4)=$a3(7) or $v0(2)=3 or 5=7
		and			$a1,	$v1,		$a0		# $a1(5)=$v1(3) and $a0(4)= 12 and 7=4
		add			$a1,	$a1,		$a0		# $a1(5)=$a1(5)+$a0(4)=4+7=11
		beq			$a1,	$a3,		end		# $a1(5)==$a3(7) ? end: PC=PC+4; 11==3 ? PC=PC+4
		slt			$a0,	$v1,		$a0		# $v1(3) < $a0(4) ? $a0=1 : $a0=0; 12 < 7 => $a0=0
		beq			$a0,	$0,			ar1		# $a0(4)==0 ? ar1 : PC=PC+4; 0==0 goto ar1
		addi		$a1,	$0,			0		#
ar1:	slt			$a0,	$a3,		$v0		# $a3(7) < $v0(2) ? $a0(4)=1 : $a0=0; 3 < 5, $a0=1
		add			$a3,	$a0,		$a1		# $a3(7)=$a0(4)+$a1(5); 1+11=12
		sub			$a3,	$a3,		$v0		# $a3(7)=$a3(7)-$v0(2); 12-5=7
		sw			$a3,	68($v1)				# $a3(7) -> M[68+$v1(3)]; 7 -> M[68+12=80]				# Test 1
		lw			$v0,	80($0)		 		# $v0(2)=M[80+0]; $v0=7
		j			end							# goto end
		addi		$v0,	$0,			1
end:	sw 			$v0,	60($0) 				# $v0(2) write M[60]; M[60]=7;							# Test 2
		jal			tag							# Jump to testJal
		sw			$v0,	40($0)				# This should not be executed if jump is ok
tag:	sw 			$ra,	40($0)				# $ra=19 -> M[40]										# Test 3
		addi		$t0,	$0,			3		# $t0=3
		addi		$t1,	$0,			5		# $t1=5
		index2Adr	$t0,	$t0,		$t1		# $t0=4*$t0+$t1=4*3+5=17
		sw			$t0,	20($0)				# $t0=17 -> M[20]										# Test 4

# SPACES
        addi        $v0,    $0,         5       # $v0(2)=5
        addi        $v1,    $0,         12      # $v1(3)=12
        addi        $a3,    $v1,        -9      # $a3(7)=$v1(3)(12)-9=3
        or          $a0,    $a3,        $v0     # $a0(4)=$a3(7) or $v0(2)=3 or 5=7
        and         $a1,    $v1,        $a0     # $a1(5)=$v1(3) and $a0(4)= 12 and 7=4
        add         $a1,    $a1,        $a0     # $a1(5)=$a1(5)+$a0(4)=4+7=11
        beq         $a1,    $a3,        end     # $a1(5)==$a3(7) ? end: PC=PC+4; 11==3 ? PC=PC+4
        slt         $a0,    $v1,        $a0     # $v1(3) < $a0(4) ? $a0=1 : $a0=0; 12 < 7 => $a0=0
        beq         $a0,    $0,         ar1     # $a0(4)==0 ? ar1 : PC=PC+4; 0==0 goto ar1
        addi        $a1,    $0,         0       #
ar1:    slt         $a0,    $a3,        $v0     # $a3(7) < $v0(2) ? $a0(4)=1 : $a0=0; 3 < 5, $a0=1
        add         $a3,    $a0,        $a1     # $a3(7)=$a0(4)+$a1(5); 1+11=12
        sub         $a3,    $a3,        $v0     # $a3(7)=$a3(7)-$v0(2); 12-5=7
        sw          $a3,    68($v1)             # $a3(7) -> M[68+$v1(3)]; 7 -> M[68+12=80]              # Test 1
        lw          $v0,    80($0)              # $v0(2)=M[80+0]; $v0=7
        j           end                         # goto end
        addi        $v0,    $0,         1
end:    sw          $v0,    60($0)              # $v0(2) write M[60]; M[60]=7;                          # Test 2
        jal         tag                         # Jump to testJal
        sw          $v0,    40($0)              # This should not be executed if jump is ok
tag:    sw          $ra,    40($0)              # $ra=19 -> M[40]                                       # Test 3
        addi        $t0,    $0,         3       # $t0=3
        addi        $t1,    $0,         5       # $t1=5
        index2Adr   $t0,    $t0,        $t1     # $t0=4*$t0+$t1=4*3+5=17
        sw          $t0,    20($0)              # $t0=17 -> M[20]                                       # Test 4