module physics_utils
contains

    subroutine compute_energy(mass, velocity, energy)
        real*8 :: mass, velocity, energy
        energy = 0.5 * mass * velocity * velocity
    end subroutine compute_energy

    function square(x) result(y)
        real :: x, y
        y = x * x
    end function square

end module physics_utils


subroutine loose_procedure(n, result)
    integer :: n, result
    integer :: i
    result = 0
    do i = 1, n
        result = result + i
    end do
end subroutine loose_procedure


function external_double(x)
    real :: x, external_double
    external_double = x * 2.0
end function external_double


program main
    use physics_utils

    real :: m, v, e
    integer :: total, count
    real :: pi
    real, dimension(10) :: arr
    integer :: i
    real :: statfunc, z

    common /shared_block/ pi, total

    statfunc(z) = z * z + 1.0

    pi = 3.14159
    m = 1.5
    v = 10.0d0
    count = 100

    call compute_energy(m, v, e)
    print *, "Energy:", e
    print *, "Square via statement function:", statfunc(4.0)

    do 10 i = 1, 10
        arr(i) = real(i) * 1.5
        if (arr(i) .gt. 10.0) goto 20
10  continue

20  continue

    call loose_procedure(10, total)
    print *, "Total:", total

end program main
