module inputs
    implicit none
    integer :: D = 1
    integer :: nx = 21
    integer :: ny = 21
    integer :: iter !number of iterations
    real :: Lx = 1
    real :: Ly = 1
    real :: delta_x
    real :: delta_y 
    double precision :: delta_t = 0.000625
    contains 
    subroutine initialise_deltas(delta_x, delta_y, Lx, Ly, nx, ny)
        integer :: nx 
        integer :: ny
        real :: Lx
        real :: Ly 
        real :: delta_x
        real :: delta_y 
        delta_x = Lx  / (nx - 1)
        delta_y = Ly / (ny - 1)
    end subroutine initialise_deltas

    subroutine initialise_from_data(nx, ny, D, iter, delta_t) 
        integer :: nx, ny, D, iter
        double precision :: delta_t 

        namelist /list/ nx, ny, D, iter, delta_t 
        open(5, file="input_data.dat")
        read(5, nml=list)
    end subroutine initialise_from_data
end module inputs