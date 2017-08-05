################################################################################
#                           Miscellaneous Functions                            #
################################################################################

# lsos: A function of improved list of objects
# {{{1
.ls.objects <- function (pos = 1, pattern, order.by, decreasing=FALSE, head=FALSE, n=5) {
    napply <- function(names, fn) sapply(names, function(x)
                                         fn(get(x, pos = pos)))
    names <- ls(pos = pos, pattern = pattern)
    obj.class <- napply(names, function(x) as.character(class(x))[1])
    obj.mode <- napply(names, mode)
    obj.type <- ifelse(is.na(obj.class), obj.mode, obj.class)
    obj.prettysize <- napply(names, function(x) {
                           capture.output(format(utils::object.size(x), units = "auto")) })
    obj.size <- napply(names, object.size)
    obj.dim <- t(napply(names, function(x)
                        as.numeric(dim(x))[1:2]))
    vec <- is.na(obj.dim)[, 1] & (obj.type != "function")
    obj.dim[vec, 1] <- napply(names, length)[vec]
    out <- data.frame(obj.type, obj.size, obj.prettysize, obj.dim)
    names(out) <- c("Type", "Size", "PrettySize", "Rows", "Columns")
    if (!missing(order.by))
        out <- out[order(out[[order.by]], decreasing=decreasing), ]
    if (head)
        out <- head(out, n)
    out
}

# shorthand
lsos <- function(..., n=10) {
    .ls.objects(..., order.by="Size", decreasing=TRUE, head=TRUE, n=n)
}
# }}}1

has_model_ext <- function (x) {
    ext <- tools::file_ext(x)
    grepl("i[dm]f", ext, ignore.case = TRUE)
}

has_epw_ext <- function (x) {
    ext <- tools::file_ext(x)
    grepl("epw", ext, ignore.case = TRUE)
}

has_idf_ext <- function (x) {
    ext <- tools::file_ext(x)
    grepl("i[dm]f", ext, ignore.case = TRUE)
}

has_imf_ext <- function (x) {
    ext <- tools::file_ext(x)
    grepl("i[dm]f", ext, ignore.case = TRUE)
}

`%||%` <- function (x, y) {
    if (is.null(x)) {
        y
    } else {
        x
    }
}