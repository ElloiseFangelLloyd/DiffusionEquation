PROGRAM diffusion
    use inputs
    use diffuse 
    use setup
    use output
    use precise
    use timings
    use diag
    implicit none 

    !need two fields to solve the diffusion equation, for n-1 and n (as in exercise guidelines)
    !initialise two arrays of temperature values 
    !type mkd is in module_precise, to change between single and double precision 
    real(mkd), dimension(:, :), allocatable :: old_solution
    real(mkd), dimension(:, :), allocatable :: new_solution

    !info for initialisation, k is a loop counter
    integer :: info, k

    !determines whether or not to open a file for diagnostic data
    logical :: first = .TRUE.

    !reads input file and updates the dummy arguments with data from the file
    call initialise_from_data(nx, ny, D, iter, delta_t)

    !just calculates values for dx and dy
    call initialise_deltas(delta_x, delta_y, Lx, Ly, nx, ny)

    !allocates and initialises the two temperature data fields
    call initialise_fields(nx, ny, old_solution, new_solution, info)

    !prints the date and time in a nice format
    call print_date_time()
    !starts timers, both walltime and cpu time
    call start_timer(count, cpu_time_start)

    k = 0;
    DO WHILE (k < 200)
        !for printing diagnostic data; see module_diag
        call generate_diagnostics(first, k, new_solution)

        !solve the actual diffusion eq
        call solve_for_temp(delta_t, delta_x, delta_y, D, old_solution, new_solution, nx, ny)

        !set the old field equal to the new updated solutions
        call update_old_field(nx, ny, old_solution, new_solution)

        !print data out
        !the intention is one file for each timestep
        !to get this, change iter to k
        !I don't want it to make 200 files every time because it's annoying
        call print_data(nx, ny, delta_x, delta_y, new_solution, iter)
        k = k + 1

    END DO

    !stops the timer and calculates the walltime and cpu time; prints
    call stop_timer(count_final, count_rate, cpu_time_end)
    call print_runtimes(count, count_final, count_rate, cpu_time_start, cpu_time_end, wall_time)

END PROGRAM diffusion

