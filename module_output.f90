module output
    use precise
implicit none
contains 
subroutine print_data(nx, ny, delta_x, delta_y, new_solution, k)
    integer :: nx, ny
    real :: delta_x, delta_y
    real(mkd), dimension(:, :), allocatable :: new_solution
    integer, optional :: k
    character(len = 100) :: filename 
    integer :: i,j

    IF (present(k)) THEN
        WRITE(filename, fmt='(A,I4.4,A)') 'diff_',k,'.dat'
    ELSE 
        filename = 'diff.dat'
    END IF


    OPEN(k, file=filename)
    DO j = 1,ny
        DO i = 1,nx
            WRITE(k,'(3E12.4)') REAL(i-1)*delta_x, REAL(j-1)*delta_y, new_solution(i,j)
        END DO
        WRITE(k,'(A)') 
    END DO
    
    CLOSE(k)
end subroutine print_data 
end module output