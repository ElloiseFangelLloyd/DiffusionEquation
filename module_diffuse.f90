module diffuse
    use precise
    implicit none
    contains 

    subroutine solve_for_temp(delta_t, delta_x, delta_y, D, old_solution, new_solution, nx, ny)
        integer :: D 
        real :: delta_x, delta_y
        double precision :: delta_t 
        real(mkd), dimension(:, :) :: old_solution
        real(mkd), dimension(:, :) :: new_solution
        integer :: nx, ny
        integer :: i,j
     
        DO j = 2,ny-1
            DO i = 2,nx-1
                new_solution(i,j) = old_solution(i,j) + (delta_t * D * &
                ((old_solution(i+1,j) - 2 * old_solution(i,j) + old_solution(i-1,j)) / &
                (delta_x ** 2) + &
                (old_solution(i,j+1) - 2 * old_solution(i,j) + old_solution(i, j-1)) / &
                (delta_y ** 2)))
            END DO
        END DO
    
    end subroutine solve_for_temp

    subroutine update_old_field(nx, ny, old_solution, new_solution)
        integer :: nx, ny
        real(mkd), dimension(:, :) :: old_solution
        real(mkd), dimension(:, :) :: new_solution
        integer :: i,j
    
        DO j = 2,ny-1
            DO i = 2,nx-1
                old_solution(i,j) = new_solution(i,j)
            END DO
        END DO
    end subroutine update_old_field

end module diffuse 