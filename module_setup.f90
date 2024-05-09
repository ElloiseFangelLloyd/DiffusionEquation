module setup 
    use precise
    implicit none
    interface initialise_fields
    module procedure init_single, init_double
    end interface initialise_fields
    contains
    subroutine init_single(nx, ny, old_solution, new_solution, info)
    integer :: nx, ny
    integer :: i,j, info
    real, dimension(:, :), allocatable :: old_solution
    real, dimension(:, :), allocatable :: new_solution

    allocate(old_solution(nx, ny), stat=info)
    allocate(new_solution(nx, ny), stat=info)
    
    !first set all the array equal to zero
    DO j = 1,ny 
        DO i = 1,nx
            old_solution(i,j) = 0
            new_solution(i,j) = 0
        END DO
    END DO
    
    !set up boundary conditions
    DO j = 1,ny 
        DO i = 1,nx
            IF (j == 1) THEN
                old_solution(i,j) = 1
                new_solution(i,j) = 1
            ELSE IF (j == ny) THEN 
                old_solution(i,j) = 1
                new_solution(i,j) = 1
            ELSE IF (i == 1) THEN
                old_solution(i,j) = 1
                new_solution(i,j) = 1
            ELSE IF (i == nx) THEN 
                old_solution(i,j) = 1
                new_solution(i,j) = 1
            END IF
        END DO
    END DO

end subroutine init_single 

subroutine init_double(nx, ny, old_solution, new_solution, info)
    integer :: nx, ny
    integer :: i,j, info
    double precision, dimension(:, :), allocatable :: old_solution
    double precision, dimension(:, :), allocatable :: new_solution

    allocate(old_solution(nx, ny), stat=info)
    allocate(new_solution(nx, ny), stat=info)
    
    !first set all the array equal to zero
    DO j = 1,ny 
        DO i = 1,nx
            old_solution(i,j) = 0.
            new_solution(i,j) = 0.
        END DO
    END DO
    
    !set up boundary conditions
    DO j = 1,ny 
        DO i = 1,nx
            IF (j == 1) THEN
                old_solution(i,j) = 1.
                new_solution(i,j) = 1.
            ELSE IF (j == ny) THEN 
                old_solution(i,j) = 1.
                new_solution(i,j) = 1.
            ELSE IF (i == 1) THEN
                old_solution(i,j) = 1.
                new_solution(i,j) = 1.
            ELSE IF (i == nx) THEN 
                old_solution(i,j) = 1.
                new_solution(i,j) = 1.
            END IF
        END DO
    END DO

end subroutine init_double
end module setup