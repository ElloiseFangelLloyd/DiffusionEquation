module diag 
    use precise
    contains 

    subroutine generate_diagnostics(first, k, new_solution)

    !--------------------------------------------------------------
    ! Purpose:    Generates diagnostic output for simulation
    ! Parameters:
    !   - first: logical flag indicating if it's the first call
    !   - k: integer identifier (e.g., simulation step)
    !   - new_solution: 2D array containing solution data
    !--------------------------------------------------------------

        logical :: first
        integer :: k
        real(mkd) :: minimum
        real(mkd), dimension(:, :) :: new_solution
    
        ! If it's the first call, initialize output file and write minimum value
        if (first) then
            first = .FALSE.
            open(10, file='diagnostics.dat')
            minimum = minval(new_solution)
            write(10, '(3E12.4)') minimum
        end if
    
        ! Write minimum value periodically (e.g., every 10 steps)
        if (mod(k, 10) == 0) then
            minimum = minval(new_solution)
            write(10, '(3E12.4)') minimum
        end if
    end subroutine generate_diagnostics
end module diag